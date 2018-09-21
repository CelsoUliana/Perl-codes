#!/usr/bin/perl -w
use strict;
 
############################################################
### Usage: perl pmd_parser.pl project.html projectDir
### ex: perl pmd_parser.pl clojure_relatorio.html clojure
### output: project_errors.txt project_classes.txt project_packages.txt
### ex: clojure_erros.txt clojure_classes.txt clojure_packages.txt
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
open HTML, "$file" or die "Couldn't open the file $file\n";
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
## open and parse PMD html file
############################################################
while (<HTML>) {
    if (/"center">(\d+)<\/td>/) {
        $index = $1;
    }
    if (/>(.*)\.java/) {
        $hash{$index}[0] = $1 . ".java";
    }
    if (/>.*>(.*)<\/a><\/td>/) {
        $hash{$index}[1] = $1;
    }
}
close HTML;
############################################################
## count frequency of errors and classes
############################################################
foreach my $key ( sort { $a <=> $b } keys %hash ) {
    $count_error{ $hash{$key}[1] }++;
    $count_classes{ $hash{$key}[0] }++;
    $error_total++;
}
############################################################
## print results in two diferent .txt files
############################################################
$class_total = keys %count_classes;
open( my $fh, '>', $file_error );
foreach my $error (
    sort { $count_error{$b} <=> $count_error{$a} }
    keys %count_error
    )
{
    print $fh "$error*$count_error{$error}\n";
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