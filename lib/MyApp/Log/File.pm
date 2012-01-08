package MyApp::Log::File;
use Moose;
use MooseX::Types::Path::Class qw!File!;

use FindBin qw!$Bin!;
use lib "$Bin/lib";
use HTTP::Date qw!time2iso!;

with 'MyApp::Log';

has file => (is => 'ro', isa => File, coerce => 1, default => "$Bin/log/$0.log");
has fh => (is => 'ro', isa => 'FileHandle', lazy_build => 1);

sub _build_fh { my $self = shift;
    -d $self->file->parent or $self->file->parent->mkpath;
    my $fh = $self->file->open('>>');
    $fh->autoflush(1);
    return $fh;
}

sub say { my ($self, $msg) = @_;
    my $ts = time2iso(time);
    $self->fh->print("[$ts] $0 : $msg\n");
}

__PACKAGE__->meta->make_immutable;
