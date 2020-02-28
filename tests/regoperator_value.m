function [pass,maxerr] = test(opt)

% Check whether regoperator returns correct matrices
%===============================================================================

n = 20;

L0 = regoperator(n,0);
L0ref = eye(n);
ok(1) = all(L0(:)==L0ref(:));

L1 = regoperator(n,1);
L1ref = diff(eye(n),1);
ok(2) = all(L1(:)==L1ref(:));

L2 = regoperator(n,2);
L2ref = diff(eye(n),2);
ok(3) = all(L2(:)==L2ref(:));

L3 = regoperator(n,3);
L2ref = diff(eye(n),3);
ok(4) = all(L3(:)==L2ref(:));

pass = all(~ok);
maxerr = 0;
 

end