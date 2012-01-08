package MyApp::Daemon;
use Moose;

extends 'MyApp';
with 'MooseX::Daemonize';

has '+log' => (default => sub {
        require MyApp::Log::File;
        return MyApp::Log::File->new;
    });

has interval => (is => 'ro', isa => 'Int', default => 1);

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
