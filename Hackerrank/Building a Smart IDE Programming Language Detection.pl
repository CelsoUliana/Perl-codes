############################################################
### Celso A. Uliana Jr - Feb 2017
############################################################

$cont = 0;
$isPy = 1;
foreach $line (<STDIN>) {
    chomp( $line );
    $_ = $line;
        if(m/include/){
            print "C\n";
            $isPy = 0;
            last;
        }
        elsif(m/import/){
            print "Java\n";
            $isPy = 0;
            last;
        }
}

if($isPy){
    print "Python\n";
}
