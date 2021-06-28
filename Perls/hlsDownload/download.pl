#!/usr/bin/perl

use strict;
use warnings;
#Get the input params
if(scalar(@ARGV) < 1){
    print "Invalid input \n";
}
#download playlist
my $playlist_link = $ARGV[0];
my $playlist = "playlist.m3u8";
`curl $playlist_link --output $playlist`;
my $index = rindex($playlist_link, "/");
my $link = substr($playlist_link, 0, $index + 1);
print $link."\n";
#download chunks
open(my $file, "<", $playlist) or die $!;
while(<$file>){
    if(index($_, ".ts") != -1){
        chomp($_);
        my $chunk = $link.$_;             
        print "Loading...$chunk"."\n"; 
        `curl $chunk --output $_`;
    }
}
close($file);
print "Clear downloaded files \n";
system("rm *.m3u8");
system("rm *.ts");