package Devel::Command;
use 5.006;
use strict;
use warnings;

use Module::Pluggable search_path=>["Devel::Command"], require=>1;

our $VERSION = '0.01';

sub install {
  my @plugins = __PACKAGE__->plugins;
  foreach my $plugin (@plugins) {
    my($cmd_name, $cmd_ref) = $plugin->signature();
    $DB::commands{$cmd_name} = $cmd_ref;
  }
  my $count = scalar @plugins;
  print DB::OUT $count, " plugin",($count == 1 ? "" : "s"), " installed\n";
}

# subs inherited by subclasses
sub signature {
  my $class = shift;
  (lc(substr($class,rindex($class,'::')+2)), 
   eval "\\&".$class."::command");
}

1;
__END__

=head1 NAME

Devel::Command - Perl extension to automatically load and register debugger command extensions

=head1 SYNOPSIS

  # in .perldb:
  use Devel::Command;
  sub afterinit {
     Devel::Command->install;
  }

=head1 DESCRIPTION

C<Devel::Command> provides a simple means to extend the Perl debugger with
custom commands. It uses C<Module::Pluggable> to locate the command modules,
and installs these into a debugger global (C<%DB::commands>) where they can
be found by a modified version of C<DB::DB>.

=head1 SEE ALSO

C<perl5db.pl>, notably the documentation for the C<DB::DB> subroutine.

=head1 AUTHOR

Joe McMahon, E<lt>mcmahon@ibiblio.orgE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2005 by Joe McMahon

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself, either Perl version 5.8.6 or,
at your option, any later version of Perl 5 you may have available.


=cut

