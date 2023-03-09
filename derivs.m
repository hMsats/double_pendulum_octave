function dydx=derivs(xin,yin,N,G,L1,L2,M1,M2)

  % /* function to fill the array of derivatives into xin */

  dydx(1)=yin(2);
  
  del=yin(3)-yin(1);
  
  % Don't do this more often than necessary
  cd=cos(del);
  sd=sin(del);
  sy1=sin(yin(1));
  sy3=sin(yin(3));
  M12=M1+M2;

  den1=M12*L1 - M2*L1*cd*cd;
  dydx(2)=(M2*L1*yin(2)*yin(2)*sd*cd+M2*G*sy3*cd+M2*L2*yin(4)*yin(4)*sd-M12*G*sy1)/den1;

  dydx(3)=yin(4);

  den2=(L2/L1)*den1;
  dydx(4)=(-M2*L2*yin(4)*yin(4)*sd*cd+M12*G*sy1*cd-M12*L1*yin(2)*yin(2)*sd-M12*G*sy3)/den2;

end
