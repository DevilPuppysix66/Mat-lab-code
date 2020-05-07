umid = [-0.240001,-0.258909,-0.264668];
hlist = [2,1,.5];

a = log((umid(1)-umid(2))/(umid(2)-umid(3)))/log(2);
c = (umid(2)-umid(3))/((hlist(2)^a) - (hlist(3)^a));
uexact = umid(3) + c*hlist(3)^a;

err = abs((uexact - umid)/uexact)*100;
err
exact = -0.267000;

err = abs((uexact - exact)/uexact)*100;
err