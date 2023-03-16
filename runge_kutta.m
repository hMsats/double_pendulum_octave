function yout=runge_kutta(xin,yin,h,N,G,L1,L2,M1,M2)
  % /* fourth order Runge-Kutta */

  hh = 0.5*h;
  xh = xin + hh;

  dydx=derivs(xin, yin,N,G,L1,L2,M1,M2); % /* first step */
  k1(1:N) = h*dydx(1:N);
  yt(1:N) = yin(1:N) + 0.5*k1(1:N);

  dydxt=derivs(xh, yt,N,G,L1,L2,M1,M2); % /* second step*/
  k2(1:N) = h*dydxt(1:N);
  yt(1:N) = yin(1:N) + 0.5*k2(1:N);

  dydxt=derivs(xh, yt,N,G,L1,L2,M1,M2); % /* thrid step */
  k3(1:N) = h*dydxt(1:N);
  yt(1:N) = yin(1:N) + k3(1:N);

  dydxt=derivs(xin + h, yt,N,G,L1,L2,M1,M2); % /* fourth step */
  k4(1:N) = h*dydxt(1:N);
  yout(1:N) = yin(1:N) + k1(1:N)/6. + k2(1:N)/3. + k3(1:N)/3. + k4(1:N)/6.;

end
