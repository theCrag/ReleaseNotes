# ReleaseNotes.pl
use FindBin qw( $Bin );
use File::Spec::Functions qw( catfile );
use lib catfile $Bin, 'lib';
use HTML::Template;

my $template = HTML::Template->new(filename => 'ReleaseNotes.tmpl');

$template->param(
   STUDENT => [
      { NAME => 'No Climbs', STATUS => 'Closed' },
      { NAME => 'No Users'   , STATUS => 'Closed' },
   ]
);
print $template->output;