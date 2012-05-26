use strict;
use Data::UUID;
use vars qw($VERSION %IRSSI);

$VERSION = '0.1';
%IRSSI = (
    authors	=> 'gege2061',
    contact	=> 'nicolas.joseph@homecomputing.fr',
    name	=> 'bitlbee_gchat',
    description	=> '/gchat <add> <account-id> <name>',
    license	=> 'GPLv2',
    changed	=> '2011-09-15',
);

my $bitlbee_channel = "&bitlbee";

sub gchat {
  my ($args, $server, $winit) = @_;
  my ($action, $accound_id, $channel) = split(/ /, $args, 3);

  my $uuid = new Data::UUID->create_str();
  my $room = "private-chat-$uuid\@groupchat.google.com";
  Irssi::active_win()->command("msg &bitlbee chat add $accound_id $room $channel");
  Irssi::active_win()->command("join &$channel");
}

Irssi::command_bind('gchat','gchat');

