package Devel::Command::Viz;

use 5.006;
use strict;
use warnings;
use GraphViz::Data::Structure;
use File::Temp qw(tempfile);

use base qw(Devel::Command);

our $VERSION = '0.01';

sub command {
  my ($arg) = (shift =~ /viz\s+(.*)/);
  chomp $arg;
  my $gvds = new GraphViz::Data::Structure(&eval($arg));
  my ($fh, $filename) = tempfile();
  print $fh $gvds->graph->as_canon;
  close $fh;
  system "dotty $filename";
  1;
}

1;
__END__

=head1 NAME

Devel::Command::HelloWorld - example debugger command extension

=head1 SYNOPSIS

  # in .perldb:
  use Devel::Command;
  sub afterinit {
     Devel::Command->install;
  }

  #In the debugger:
  DB<1> helloworld
  Hello, world!
  DB<2>

=head1 DESCRIPTION

C<Devel::Command::HelloWorld> is an example command plugin for Devel::Command.
It demonstrates the basic code needed to implement a command that will automatically
be loaded and installed by Devel::Command.

=head1 SEE ALSO

C<perl5db.pl>, C<Devel::Command>

=head1 AUTHOR

Joe McMahon, E<lt>mcmahon@ibiblio.orgE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2005 by Joe McMahon

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself, either Perl version 5.8.6 or,
at your option, any later version of Perl 5 you may have available.


=cut
