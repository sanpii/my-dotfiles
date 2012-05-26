#!/usr/bin/perl

#    This program is free software: you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation, either version 3 of the License, or
#    (at your option) any later version.
#
#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.
#
#    You should have received a copy of the GNU General Public License
#    along with this program.  If not, see <http://www.gnu.org/licenses/>.

use strict;
use Irssi;
my %IRSSI = (
	'authors'	=>	'Haui',
	'contact'	=>	'haui45@web.de',
	'description'	=>	'nicklist for irssi',
	'license'	=>	'GPL',
	'version'	=>	'0.1',
	'bugs'		=>	'yep :D'
	);

my @array;
my $string;
my $nicklist = "";
my $nicklistheight = 2;
sub init {
	my $current = Irssi::active_win()->{refnum};	#save the current window
	Irssi::command("window new");			#create a new window
	Irssi::command("window size $nicklistheight");		# height of our nicklist
	Irssi::command("window name nicklist");		#nicklist identifier
	Irssi::command("window number 99");		#nicklist number 
	$nicklist = Irssi::window_find_name("nicklist");
	Irssi::command("window $current");
}
sub update {
	my $witem = Irssi::active_win()->{active};	#get the active windowitem
	if($witem->{type} ne "CHANNEL"){		#clear the nicklist, if we're
		$nicklist->command("clear");		#not in a channel
		return;
	}
	$string ="";
	@array = $witem->nicks();			#read in the nicks of the channel		
	foreach(@array){
		my $tmp="";
		if($_->{op} == 1){			#
			$tmp = "\@";			#
		}					#build the actual nicklist
		elsif($_->{voice} == 1){		#
			$tmp = "+";			#
		}					#
		else {					#	
			$tmp = "#";			#	
		}					#
							#
		$tmp .= $_->{nick};			#
							#
		$string .= " " . $tmp;			#
		chomp $string;				#
	}
	chomp $string;
	my @sorted = sort {lc substr($a,1, length($a)-1) cmp 
			lc substr($b, 1, length($b)-1)} split(" ", $string);
	$string = join(" ", @sorted);
	$string =~ s/#//g;
	$nicklist->command("clear");	
	$nicklist->command("echo $string");

	$string = "";
}
sub part {
	my ($info1, $channel, $nick) = @_;
	my $witem = Irssi::active_win()->{active};
	if ($witem->{name} ne $channel){
		return;
	}
	if($witem->{type} ne "CHANNEL"){
		$nicklist->command("clear");
		return;
	}
	$string ="";
	@array = $witem->nicks();
	foreach(@array){
		my $tmp="";
		if($_->{op} == 1){
			$tmp = "\@";
		}
		elsif($_->{voice} == 1){
			$tmp = "+";
		}
		else {
			$tmp = "#";
		}
		$tmp .= $_->{nick};
			
		$string .= " " . $tmp unless $_->{nick} eq $nick;
		chomp $string;
	}
	chomp $string;
	my @sorted = sort {lc substr($a,1, length($a)-1) cmp 
			lc substr($b, 1, length($b)-1)} split(" ", $string);
	$string = join(" ", @sorted);
	$string =~ s/#//g;
	$nicklist->command("clear");	
	$nicklist->command("echo $string");

	$string = "";
}
sub quit {
	my ($server, $nick) = @_;
	my $witem = Irssi::active_win()->{active};
	if($witem->{type} ne "CHANNEL"){
		return;
	}
	$string ="";
	@array = $witem->nicks();
	foreach(@array){
		my $tmp="";
		if($_->{op} == 1){
			$tmp = "\@";
		}
		elsif($_->{voice} == 1){
			$tmp = "+";
		}
		else {
			$tmp = "#";
		}
		$tmp .= $_->{nick};
			
		$string .= " " . $tmp unless $_->{nick} eq $nick;
		chomp $string;
	}
	chomp $string;
	my @sorted = sort {lc substr($a,1, length($a)-1) cmp 
			lc substr($b, 1, length($b)-1)} split(" ", $string);
	$string = join(" ", @sorted);
	$string =~ s/#//g;
	$nicklist->command("clear");	
	$nicklist->command("echo $string");
	$string = "";
}


sub close {
	my ($command, $args) = @_;
	if($command =~ m/script load nicklist/i){	#prevent irssi from creating multiple nicklist windows
		$nicklist->destroy();
	}
	if ($command =~ m/script unload nicklist/i){	#destroy the nicklist window when unloading the script
		$nicklist->destroy();
	}
}

init();
update();

Irssi::signal_add('window changed', 'update');		#user changes the current window, e.g. by pressing alt+2
Irssi::signal_add('channel joined', 'update');		#user joined a channel
Irssi::signal_add('send command', 'close');		#user unloads the script
Irssi::signal_add('message join', 'update');		#someone joined the channel
Irssi::signal_add('message part', 'part');		#someone left the channel
Irssi::signal_add('message kick', 'part');		#etc...
Irssi::signal_add('nick mode changed', 'update');	#
Irssi::signal_add('message own_nick', 'update');	#
Irssi::signal_add('message nick', 'update');	#
Irssi::signal_add('message quit', 'quit');		#

