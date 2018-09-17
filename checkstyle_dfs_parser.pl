#!/usr/bin/perl -w
use strict;
 
############################################################
### Usage: perl checkstyle_parser.pl project.txt dirname
### ex: perl checkstyle_parser.pl checkstyle_clojure.txt clojure
### output: project_errors.txt project_classes.txt project_packages
### ex: clojure_packages.txt clojure_classes.txt clojure_errors.txt
### ex: clojure_error_graph,clojure_class_graph,2 clojure packages graph
###
### Celso A. Uliana Jr - Feb 2017
############################################################
 
############################################################
## variable declaration
############################################################
my $file         = shift;
my $name         = shift;
my $file_error   = $name . "_errors.txt";
my $file_class   = $name . "_classes.txt";
my $file_package = $name . "_packages.txt";
my %hash;
my $index;
my %count_error;
my %count_classes;
my %count_package;
my $error_total = 0;
my $class_total = 0;
my @error_temp;
my @error_count;
my @class_temp;
my @class_count;
my @package_temp;
my @package_count;
my @package_class;
open TXT, "$file" or die "Couldn't open the file $file\n";
############################################################
## some subroutines
############################################################
sub DFS {
    my $start_dir = shift;
    my @queue     = ($start_dir);
    my $sum;
 
    while ( scalar(@queue) > 0 ) {
        my $dir = pop(@queue);
        $sum = 0;
        if ( -d $dir ) {
            foreach my $class ( sort { lc $a cmp lc $b } keys %count_classes )
            {
                if ( $class =~ /\Q$dir\E/ ) {
                    $sum += $count_classes{$class};
                }
            }
        }
        chdir("$dir") or die "$!";
        chomp( $count_package{$dir}[1] = `find . -name '*.java' | wc -l` );
        $count_package{$dir}[0] = $sum;
        chdir() or die "$!";
        chdir("TP2") or die "$!";
 
        my ( $files, $dirs ) = get_dirs_files($dir);
        push @queue, @$dirs;
    }
}
 
sub get_dirs_files {
    my $sdir = shift;
 
    opendir( my $dh, $sdir ) || die "can't opendir $sdir : $!";
    my @entries = grep { !( /^\.$/ || /^\.\.$/ ) } readdir($dh);
    @entries = map {"$sdir/$_"} @entries;    #change to absolute paths
    closedir $dh;
 
    my @files = grep( -f $_, @entries );
    my @dirs  = grep( -d $_, @entries );
    return ( \@files, \@dirs );
}
############################################################
## open and parse html file
############################################################
while (<TXT>) {
    if (/(\/home\/celso\/TP2.*\.java):/) {
        $count_classes{$1}++;
    }
    if (/\[(\w{6,})\]/) {
        $count_error{$1}++;
    }
}
close TXT;
############################################################
## print results in two diferent .txt files
############################################################
foreach my $temp ( keys %count_error ) {
    $error_total = $error_total + $count_error{$temp};
}
open( my $fh, '>', $file_error );
print $fh "quantidade de erros totais = $error_total\n";
foreach
  my $error ( sort { $count_error{$b} <=> $count_error{$a} } keys %count_error )
{
    print $fh "$error*#*$count_error{$error}\n";
}
close $fh;
open( my $ff, '>', $file_class );
foreach my $class ( sort { $count_classes{$b} <=> $count_classes{$a} }
    keys %count_classes )
{
    print $ff "$class*#*$count_classes{$class}\n";
}
close $ff;
############################################################
## Search directory tree
############################################################
DFS($name);
open( my $fg, '>', $file_package );
foreach my $package (
    sort { $count_package{$b}[0] <=> $count_package{$a}[0] }
    keys %count_package
    )
{
    print $fg
        "$package;$count_package{$package}[0];$count_package{$package}[1]\n";
}
close $fg;
exit();