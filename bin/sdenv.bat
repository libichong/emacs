@rem = '--*-Perl-*--
@echo off
if "%OS%" == "Windows_NT" goto WinNT
perl -x -S "%0" %1 %2 %3 %4 %5 %6 %7 %8 %9
goto endofperl
:WinNT
perl -x -S %0 %*
if NOT "%COMSPEC%" == "%SystemRoot%\system32\cmd.exe" goto endofperl
if %errorlevel% == 9009 echo You do not have Perl in your PATH.
if errorlevel 1 goto script_failed_so_exit_with_non_zero_val 2>nul
goto endofperl
@rem ';
#!perl
#line 15
use Cwd;
use File::Basename;

sub sdroot{
    my $CWD = getcwd;
# get current path
    while (! -e "$CWD/sd.ini"){
        if ($CWD =~ /^\w\:\/$/){
            return "";
        }
        $CWD = dirname($CWD);
    }
    $CWD =~ s/\//\\/g;
    return $CWD;
}

sub sdenv_init{
    my $sdroot = shift;
    system("$sdroot\\tools\\path1st\\myenv.cmd&set>$sdroot\\env.txt");
}

sub sdenv_load{
    my $sdroot = shift;
    if (! -e "$sdroot\\env.txt"){
        sdenv_init $sdroot;
    }
    open(my $FD, "<", "$sdroot\\env.txt") or die "$!";
    while (<$FD>){
        if (/^(\w+)=(.*)$/){
            $ENV{$1}=$2;
        }
    }
    close $FD;
}

sub main{
    my $sdroot = sdroot;
    sdenv_load $sdroot;

    if ($ARGV[0] eq "clean"){
        unlink "$sdroot\\env.txt";
    }
    elsif ($ARGV[0] eq "init"){
        sdenv_init $sdroot;
    }
    elsif ($ARGV[0] eq "show"){
        print "SDROOT: $sdroot\n";
    }
    else{
        system "cmd.exe", "/c", @ARGV;
    }
}

main;

__END__
:endofperl
