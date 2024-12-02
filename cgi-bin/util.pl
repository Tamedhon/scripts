
sub cat {
  local($line);
  open (FILE, shift);
  while ($line=<FILE>)
  {
    $line =~ s/\$TITLE/$TITLE/g;
    $line =~ s/\$HEADER/$HEADER/g;
    $line =~ s/\$NAVMEN/$NAVMEN/g;
    $line =~ s/\$INHTXT/$INHTXT/g;
    $line =~ s/\$BANNERT/$BANNERT/g;
    print $line;
  }
  close (FILE);
}

sub catfile {
  local($all);
  local($line);
  open (FILE, shift);
  while ($line=<FILE>)
  {
    $all.=$line;
  }
  close (FILE);
  return $all;
}

return 1;
