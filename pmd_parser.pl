#!/usr/bin/perl -w
use strict;

############################################################
### Usage: perl pmd_parser.pl project.xml
### ex: perl pmd_parser.pl clojure_relatorio.xml
### output: project_errors.txt project_classes.txt project_packages.txt
### ex: clojure_errors.txt clojure_classes.txt clojure_packages.txt
###
### Celso A. Uliana Jr - April 2017
############################################################

############################################################
## variable declaration
############################################################
my $file         = shift;
my $name         = $file;
$name            =~ s/(.*)\..*/$1/;
my $file_error   = $name . "_errors.txt";
my $file_class   = $name . "_classes.txt";
my $file_package = $name . "_packages.txt";
my %count_error;
my %count_classes;
my %count_package;
my $aux;
open XML, "$file" or die "Couldn't open the file $file\n";
############################################################
## open and parse PMD xml file
############################################################
while (<XML>) {
    if (/class="([^"]*)"/) {
        $count_classes{$1}++;
    }
    if(/rule="(.*)" ruleset=/){
       	$aux = $1;
	   	$count_error{$1}[0]++;
	}
    if (/package="(.*)" class/) {
        $count_package{$1}++;
    }
    if (/priority="(.*)">/) {
        $count_error{$aux}[1] = $1;
    }
}
close XML;
######################################################
## print results in three diferent .txt files
############################################################
open( my $fh, '>', $file_error );
foreach my $error (
    sort { $count_error{$b}[0] <=> $count_error{$a}[0] }
    keys %count_error
    )
{
    print $fh "$error;$count_error{$error}[0];$count_error{$error}[1]\n";
}
close $fh;
open( my $ff, '>', $file_class );
foreach my $class (
    sort { $count_classes{$b} <=> $count_classes{$a} }
    keys %count_classes
    )
{
    print $ff "$class;$count_classes{$class}\n";
}
open( my $fg, '>', $file_package );
foreach my $package (
    sort { $count_package{$b} <=> $count_package{$a} }
    keys %count_package
    )
{
    print $fg "$package;$count_package{$package}\n";
}
close $fg;