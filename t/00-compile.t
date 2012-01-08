use Test::More;
use FindBin qw!$Bin!;
use lib "$Bin/../lib";
BEGIN {
    my @modules = qw!
        MyApp
        MyApp::Daemon
        MyApp::Log
        MyApp::Log::Console
        MyApp::Log::File
    !;
    plan tests => scalar @modules;
    use_ok $_ for @modules;
}
