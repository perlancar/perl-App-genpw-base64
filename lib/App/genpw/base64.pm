package App::genpw::base64;

# DATE
# VERSION

use 5.010001;
use strict;
use warnings;

use App::genpw ();

our %SPEC;

my %args = %{$App::genpw::SPEC{genpw}{args}};
delete $args{patterns};
delete $args{case};

$SPEC{genpw} = {
    v => 1.1,
    summary => 'Generate random password using base64 characters',
    description => <<'_',

_
    args => {
        %args,
    },
    examples => [
    ],
};
sub genpw {
    my %args = @_;

    my $min_len = $args{len} // $args{min_len} // 15;
    my $max_len = $args{len} // $args{max_len} // 30;

    my $res = App::genpw::genpw(
        %args,
        patterns => ["%${min_len}\$${max_len}m"],
    );

    if ($res->[0] == 200) {
        # pad result
        for my $pass (@{ $res->[2] }) {
            $pass .= "=" while length($pass) % 4;
        }
    }

    $res;
}

1;
# ABSTRACT:

=head1 SYNOPSIS

See the included script L<genpw-base64>.


=head1 SEE ALSO

L<https://en.wikipedia.org/wiki/Base64>

L<genpw> (from L<App::genpw>)

L<genpw-base58> (from L<App::genpw::base58>)

L<genpw-base56> (from L<App::genpw::base56>)
