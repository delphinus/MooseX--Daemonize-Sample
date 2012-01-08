package MyApp;
use Moose;

has log => (is => 'ro', does => 'MyApp::Log', default => sub {
        require MyApp::Log::Console;
        return MyApp::Log::Console->new;
    });

has counter => (traits => ['Counter'], is => 'ro', isa => 'Int', default => 0,
    handles => {
        inc_counter => 'inc',
    });

sub run { my $self = shift;
    $self->inc_counter;
    $self->log->say($self->counter);
}

__PACKAGE__->meta->make_immutable;
