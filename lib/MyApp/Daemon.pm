package MyApp::Daemon;
use Moose;

extends 'MyApp';
with 'MooseX::Daemonize';

has [qw!+ignore_zombies +no_double_fork +progname +basedir
    +stop_timeout +dont_close_all_files +counter!]
    => (traits => ['NoGetopt']);

has '+pidbase' => (
    documentation => 'directory which has pid file. default : ./run');
has '+pidfile' => (
    documentation => 'pid filename. default: myapp_daemon.pid');
has '+foreground' => (
    documentation => 'run foreground');

has '+log' => (traits => ['NoGetopt'],
    default => sub {
        require MyApp::Log::File;
        return MyApp::Log::File->new;
    });

has interval => (traits => ['Getopt'], cmd_aliases => ['i'],
    documentation => 'interval between exec. unit : second',
    is => 'ro', isa => 'Int', default => 10);

sub BUILD { my $self = shift;
    -d $self->pidbase or $self->pidbase->mkpath;
}

after start => sub { my $self = shift;
    $self->is_daemon or return;
    $self->log->start;
    $self->run;
};

before stop => sub { my $self = shift;
    $self->log->end;
};

override run => sub { my $self = shift;
    while (1) {
        super;
        sleep $self->interval;
    }
};

__PACKAGE__->meta->make_immutable;
