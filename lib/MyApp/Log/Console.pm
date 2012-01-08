package MyApp::Log::Console;
use Moose;
with 'MyApp::Log';

sub say { my ($self, $msg) = @_;
    print "$msg\n";
}

sub start {}
sub end {}

__PACKAGE__->meta->make_immutable;
