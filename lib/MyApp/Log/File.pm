package MyApp::Log::File;
use Moose;
use MooseX::Types::Path::Class qw!File!;
with 'MyApp::Log';

use FindBin qw!$Bin!;
use HTTP::Date qw!time2iso!;

has file => (is => 'ro', isa => File, coerce => 1, default => "$Bin/log/$0.log");
has fh => (is => 'rw', isa => 'Maybe[FileHandle]');

sub _get_fh { my $self = shift;
    -d $self->file->parent or $self->file->parent->mkpath;
    $self->fh($self->file->open('>>'));
    $self->fh->autoflush(1);
}

sub say { my ($self, $msg) = @_;
    $self->fh or $self->_get_fh;
    my $ts = time2iso(time);
    $self->fh->print("[$ts] $0 : $msg\n");
}

sub start { my $self = shift;
    $self->say('START!');
}

sub end { my $self = shift;
    $self->say('END!');
    $self->fh->close;
    $self->fh(undef);
}

__PACKAGE__->meta->make_immutable;
