# - seeks.pl

use Irssi;
use utf8;
use LWP::UserAgent;
use JSON -support_by_pp;
use strict;
use vars qw($VERSION %IRSSI);

$VERSION = '1.00';
%IRSSI = (
    authors     => 'gege2061',
    contact     => 'gege2061@homecomputing.fr',
    name        => 'Seeks',
    description => 'This script queries seeks and returns the results.',
    license     => 'Beerware',
);

## Usage:
## /seeks [-p, prints to current window] [-<number>, number of searchresults returned] search-criteria1 search-criteria2 ...
##
## History:
## - Wen Apr 27 2011
##   Version 0.1 - Initial release
## -------------------------------

#-------------------------------------------------
my $nr_sites = 3; # Search-results returned
my $prefix = ""; # Message printed before results
my $seeks_node = "seeks.homecomputing.fr";
#-------------------------------------------------

sub cmd_seeks {

    my ($data, $server, $witem) = @_;
    my $i = 0;
    my $url = "";
    my $mode = "quiet";

    # If user supplied nr_sites, activate his setting
    if ($data =~ /-(\d+)/) {
        $nr_sites = $1;
        $data =~ s/-\d+//g; # remove nr_sites from $data
    }

    # Switch to public mode
    # and return error msg if invalid window
    if ($data =~ /-p/) {
        $mode = "public";
        if (!$witem) {
          Irssi::active_win()->print("Must be run run in a valid window (CHANNEL|QUERY)");
          return;
        }
        $data =~ s/-p//g; # remove -p from $data
    }

    # Format the query-string
    $data =~ s/\s/+/g;
    my $query = $data;

    # Initialize LWP
    my $ua = new LWP::UserAgent;
    $ua->agent("AgentName/0.1 " . $ua->agent);

    # Do the actual seach
    my $req = new HTTP::Request GET => "http://$seeks_node/search?q=$query&output=json";
    my $res = $ua->request($req);
    my $content = $res->content;

    my $json = new JSON;
    my $json_data = $json->allow_nonref->decode($content);
    foreach my $snippet(@{$json_data->{snippets}}){
        $i++;
        utf8::decode($snippet->{title});
        if ( $mode eq "public") {
            $witem->command("/msg * $i: $snippet->{title} <$snippet->{url}>");
        }
        else {
            Irssi::active_win()->print("$i: $snippet->{title} <$snippet->{url}>");
        }
        if ($i >= $nr_sites) {
            return;
        }
    }
}

Irssi::command_bind('seeks', 'cmd_seeks');

