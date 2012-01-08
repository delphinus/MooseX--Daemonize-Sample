package MyApp::Daemon;
use Moose;
use MyApp::Log;

extends 'MyApp';
with 'MooseX::Daemonize';

has '+log' => (default => sub {
        require MyApp::Log::File;
        MyApp::Log::File->new;
    });

has interval => (is => 'ro', isa => 'Int', default => 1);

sub BUILD { my $self = shift;
    -d $self->pidbase or $self->pidbase->mkpath;
}

override run => sub { my $self = shift;
    while (1) {
        super;
        sleep $self->interval;
    }
};

__PACKAGE__->meta->make_immutable;
