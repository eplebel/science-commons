** Below are first the items that are relevant. These are the eight dilemmas that are measured to probe participants' sexual and emotional jealousy. There were 
** 6 people that did not fill in their gender. There were 86 males in the sample, and 92 women. In total, only 72 filled in the last question, and 68 women filled in the final question. 
** We used this final question as criterion (although questions before that were also not always filled in). 


FREQUENCIES VARIABLES=Item22
  /ORDER=ANALYSIS.

SORT CASES  BY Gender.
SPLIT FILE SEPARATE BY Gender.

FREQUENCIES VARIABLES=Item3 Item4 Item7 Item10 Item13 Item18 Item21 Item22
  /ORDER=ANALYSIS.

DESCRIPTIVES VARIABLES=Age
  /STATISTICS=MEAN STDDEV MIN MAX.

*** Selecting on the basis of the last question. 

USE ALL.
COMPUTE filter_$=(Item22>0).
VARIABLE LABELS filter_$ 'Item22>0 (FILTER)'.
VALUE LABELS filter_$ 0 'Not Selected' 1 'Selected'.
FORMATS filter_$ (f1.0).
FILTER BY filter_$.
EXECUTE.


SORT CASES  BY Gender.
SPLIT FILE SEPARATE BY Gender.

FREQUENCIES VARIABLES=Item3 Item4 Item7 Item10 Item13 Item18 Item21 Item22
  /ORDER=ANALYSIS.

** Below gives also the results. Frequencies are included below to make it a meaningful comparison and have been drawn from the analysis above. Odds ratios were calculated here: http://www.vassarstats.net/odds2x2.html. 
** Cohen's d are calculated here: http://www.polyu.edu.hk/mm/effectsizefaqs/calculator/calculator.html. I am writing the remainder of the results directly in the paper. 

SPLIT FILE OFF.
CROSSTABS
  /TABLES=Item3 BY Gender
  /FORMAT=AVALUE TABLES
  /STATISTICS=CHISQ 
  /CELLS=COUNT
  /COUNT ROUND CELL.

SPLIT FILE OFF.
CROSSTABS
  /TABLES=Item4 BY Gender
  /FORMAT=AVALUE TABLES
  /STATISTICS=CHISQ 
  /CELLS=COUNT
  /COUNT ROUND CELL.

SPLIT FILE OFF.
CROSSTABS
  /TABLES=Item7 BY Gender
  /FORMAT=AVALUE TABLES
  /STATISTICS=CHISQ 
  /CELLS=COUNT
  /COUNT ROUND CELL.

SPLIT FILE OFF.
CROSSTABS
  /TABLES=Item10 BY Gender
  /FORMAT=AVALUE TABLES
  /STATISTICS=CHISQ 
  /CELLS=COUNT
  /COUNT ROUND CELL.

SPLIT FILE OFF.
CROSSTABS
  /TABLES=Item13 BY Gender
  /FORMAT=AVALUE TABLES
  /STATISTICS=CHISQ 
  /CELLS=COUNT
  /COUNT ROUND CELL.

SPLIT FILE OFF.
CROSSTABS
  /TABLES=Item18 BY Gender
  /FORMAT=AVALUE TABLES
  /STATISTICS=CHISQ 
  /CELLS=COUNT
  /COUNT ROUND CELL.

SPLIT FILE OFF.
CROSSTABS
  /TABLES=Item21 BY Gender
  /FORMAT=AVALUE TABLES
  /STATISTICS=CHISQ 
  /CELLS=COUNT
  /COUNT ROUND CELL.

SPLIT FILE OFF.
CROSSTABS
  /TABLES=Item22 BY Gender
  /FORMAT=AVALUE TABLES
  /STATISTICS=CHISQ 
  /CELLS=COUNT
  /COUNT ROUND CELL.

SPLIT FILE OFF.
COMPUTE SJS=Mean(item3, item4, item7, item10, item13, item18, item21, item22). 
EXECUTE.

** In order to investigate whether the overall score would hold, we also conducted a simple t-test.
** Variances were equal (p = .352). The differences between groups were ns, p = .673 

T-TEST GROUPS=Gender(1 2)
  /MISSING=ANALYSIS
  /VARIABLES=SJS
  /CRITERIA=CI(.95).


DESCRIPTIVES VARIABLES=Age
  /STATISTICS=MEAN STDDEV MIN MAX.


*** Some of the data was collected in a non public setting. This variable however did not influence the outcome of the results. 

UNIANOVA SJS BY Setting Gender
  /METHOD=SSTYPE(3)
  /INTERCEPT=INCLUDE
  /CRITERIA=ALPHA(0.05)
  /DESIGN=Setting Gender Setting*Gender.

/* Written by Andrew F. Hayes */.
/* http://www.afhayes.com */.
/* Version 4.2 */.
DEFINE INDIRECT (y = !charend('/')/x = !charend('/')/m = !charend('/')/c=!charend('/') 
    !default(xxxxx)/
  boot =!charend('/') !default(1000)/conf = !charend('/') !default(95)/percent = !charend('/') 
    !default(0)/bc = !charend('/')
  !default(1)/bca = !charend('/') !default(0)/normal = !charend ('/') !default(0)/contrast = 
    !charend ('/') !default(0)/iterate = !charend('/') !default(10000)/converge = 
  !charend('/') !default(.0000001)).
PRESERVE.
SET LENGTH = NONE.
SET MXLOOPS = 10000001.
SET SEED = RANDOM.
SET PRINTBACK = OFF.
MATRIX.
get dd/variables = !y !x !m/names = nm/MISSING = OMIT.
compute temp = ncol(dd).
get dd2/variables = !y !x SOI_avg/MISSING = OMIT.
compute nc = ncol(dd)-ncol(dd2).
compute ovals = ncol(design(dd(:,1))).
do if (ovals = 2).
   compute omx = cmax(dd(:,1)).
   compute omn = cmin(dd(:,1)).
   compute dd(:,1) = (dd(:,1) = omx).
   compute rcd = {omn, 0; omx, 1}.
end if.
compute nm = t(nm).
compute outv = t(nm(1,1)).
compute n = nrow(dd).
compute nv = ncol(dd).
compute con = make(n,1,1).
compute dat2 = dd.
compute dat = dd.
compute bzx = make(nv-2-nc,1,0).
compute bzxse = make(nv-2-nc,1,0).
compute b=make((nv-1-nc),(nv-1-nc),0).
compute resid = make(n,(nv-nc),0).
compute info = make((2*(nv-nc-2)+1),(2*(nv-nc-2)+1),0).
compute imat = make(ncol(info),4,1).
compute imat(1:(nv-nc-2),1)=t({2:(nv-nc-1):1}).
compute imat(1:(nv-nc-2),3)=t({2:(nv-nc-1):1}).
compute imat((nv-nc-1):(ncol(info)-1),2)=t({2:(nv-nc-1):1}).
compute imat((nv-nc-1):(ncol(info)-1),4)=t({2:(nv-nc-1):1}).
compute imat((nv-nc-1):(ncol(info)-1),1)=make((nv-nc-2),1,(nv-nc)).
compute imat((nv-nc-1):(ncol(info)-1),3)=make((nv-nc-2),1,(nv-nc)).
compute imat(ncol(info),:)={(nv-nc),1,(nv-nc),1}.
compute cname=
    {"C1";"C2";"C3";"C4";"C5";"C6";"C7";"C8";"C9";"C10";"C11";"C12";"C13";"C14";"C15";"C16";"C17"}.
compute cname=
    {cname;"C18";"C19";"C20";"C21";"C22";"C23";"C24";"C25";"C26";"C27";"C28";"C29";"C30";"C31"}.
compute cname=
    {cname;"C32";"C33";"C34";"C35";"C36";"C37";"C38";"C39";"C40";"C41";"C42";"C43";"C44";"C45"}.
compute p0=-.322232431088.
compute p1 = -1.
compute p2 = -.342242088547.
compute p3 = -.0204231210245.
compute p4 = -.0000453642210148.
compute q0 = .0993484626060.
compute q1 = .588581570495.
compute q2 = .531103462366.
compute q3 = .103537752850.
compute q4 = .0038560700634.
compute conf = rnd(!conf).
compute lowalp = 0.5*(1-(conf/100)).
compute upalp = 0.5*(1+(conf/100)).
compute zbca = {lowalp; upalp}.
do if (!boot > 999).
   compute btn = trunc(!boot/1000)*1000.
   compute lpmax = n+1+btn.
   else.
   compute btn = 1.
   compute lpmax = 1.
end if.
compute blowp = trunc(lowalp*btn).
do if (blowp < 1).
  compute blowp = 1.
end if.
compute bhighp = trunc((upalp*btn)+1).
do if (bhighp > btn).
  compute bhighp = btn.
end if.
compute indeff = make(n+1+btn,nv-1-nc,-9999).
compute bdbp = 0.
loop #d = 1 to lpmax.
   do if (#d = (n+2)).
    compute dat = dat2.
    compute con = make(n,1,1).
  end if.
  do if (#d > 1 and #d < (n+2)).
    do if (#d = 2).
      compute con = make((n-1),1,1).
      compute dat = dat2(2:n,:).
    else if (#d = (n+1)).
      compute dat = dat2(1:(n-1),:).
    else.
      compute dat = {dat2(1:(#d-2),:);dat2((#d:n),:)}.
    end if.
  end if.
  do if (#d > (n+1)).
    loop.
    compute v=trunc(uniform(n,1)*n)+1.
    compute dat(:,1:nv) = dat2(v,1:nv).
    compute dat3 = {con,dat(:,2:ncol(dat))}.
    compute rk = (rank(dat3)=ncol(dat3)).
    compute bdbp = bdbp+(1-rk).
    end loop if (rk = 1).
  end if.
  compute x = dat(:,2).
  compute m = dat(:,3:(nv-nc)).
  compute y = dat(:,1).
  compute xz = dat(:,2:nv).
  compute xo = {con,x}.
  do if (nc > 0).
    compute c = dat(:,(nv-nc+1):nv).
    compute xo = {xo, c}.
  end if.
  loop #k = 3 to (nv-nc).
     compute ytmp = dat(:,#k).
     compute bzxt = inv(t(xo)*xo)*t(xo)*ytmp.
     compute bzx((#k-2),1)=bzxt(2,1).
     do if (#d = 1).
       compute resid(:,#k-1) = ytmp-(xo*bzxt).
       compute mse=csum((ytmp-(xo*bzxt))&**2)/(n-2-nc).
       compute olscm=(mse*inv((t(xo)*xo))).
       compute bzxse((#k-2),1)=sqrt(olscm(2,2)).
     end if.
  end loop. 
  do if (#d = 1).
    do if (nc > 0).
      compute cnt = dd(:,(nv-(nc-1)):nv)).
      compute xo = {con,x,cnt}.
    else.
      compute xo = {con,x}.
    end if.
   do if (ovals = 2).
   compute pt2 = make(nrow(y),1,(csum(y)/nrow(y))).
   compute pt1 = make(nrow(y),1,0.5).
   compute bt1 = make(ncol(xo),1,0).
   compute LL1 = 0.
   loop jjj = 1 to !iterate.
    compute vt1 = mdiag(pt1&*(1-pt1)).
    compute byx = bt1+inv(t(xo)*vt1*xo)*t(xo)*(y-pt1).
    compute pt1 = 1/(1+exp(-(xo*byx))).
    compute itprob = csum((pt1 < .00000000000001) or (pt1 > .99999999999999)).
    do if (itprob = 0).
    compute LL = y&*ln(pt1)+(1-y)&*ln(1-pt1).
    compute LL2 = -2*csum(ll).
    end if.
    do if (abs(LL1-LL2) < !converge).
      compute vt1 = mdiag(pt1&*(1-pt1)).
      compute varb = inv(t(xo)*vt1*xo).
      compute olscm = diag(varb).
      break.
    end if.
    compute bt1 = byx.
    compute LL1 = LL2.
    end loop.
    compute byx = byx(2,1).
    compute byxse = sqrt(olscm(2,1)).
    do if (jjj > !iterate).
     compute itprob = 2.
    end if.
  end if.
    do if (ovals <> 2).
    compute byx = inv(t(xo)*xo)*t(xo)*y.
    compute mse=csum((y-(xo*byx))&**2)/(n-2-nc).
    compute olscm=(mse*inv((t(xo)*xo))).
    compute byxse = sqrt(olscm(2,2)).
    compute byx = byx(2,1).
    end if.
  end if.
  compute xzo = {con,xz}.
do if (ovals = 2).
compute pt2 = make(nrow(y),1,(csum(y)/nrow(y))).
compute LL3 = y&*ln(pt2)+(1-y)&*ln(1-pt2).
compute LL3 = -2*csum(LL3).
compute pt1 = make(nrow(y),1,0.5).
  compute bt1 = make(ncol(xzo),1,0).
  compute LL1 = 0.
  loop jjj = 1 to !iterate.
    compute vt1 = mdiag(pt1&*(1-pt1)).
    compute byzx = bt1+inv(t(xzo)*vt1*xzo)*t(xzo)*(y-pt1).
    compute pt1 = 1/(1+exp(-(xzo*byzx))).
    compute itprob = csum((pt1 < .00000000000001) or (pt1 > .99999999999999)).
    do if (itprob = 0).
    compute LL = y&*ln(pt1)+(1-y)&*ln(1-pt1).
    compute LL2 = -2*csum(ll).
    end if.
    do if (abs(LL1-LL2) < !converge).
      compute vt1 = mdiag(pt1&*(1-pt1)).
      compute varb = inv(t(xzo)*vt1*xzo).
      compute olscm = diag(varb).
      break.
    end if.
    compute bt1 = byzx.
    compute LL1 = LL2.
  end loop.
  compute byzx2 = byzx(3:(nv-nc),1).
  do if (nc > 0).
      compute bcon = byzx((nv-nc+1):nv,1).
      compute bconse = sqrt(olscm((nv-nc+1):nv,1)).
    end if.
    compute cprime = byzx(2,1).
    compute cprimese = sqrt(olscm(2,1)).
    compute byzx2se = sqrt(olscm(3:(nv-nc),1)). 
    do if (#d = 1).
    compute pi = (exp(xzo*byzx)/(1+exp(xzo*byzx))).
    compute resid(:,ncol(resid))=((y-pt1)/abs(y-pt1))&*sqrt(-2*(LL)).
    end if.
do if (jjj > !iterate).
   compute itprob = 2.
end if.
end if.
  do if (ovals <> 2).
  compute byzx = inv(t(xzo)*xzo)*t(xzo)*y.
  compute byzx2 = byzx(3:(nv-nc),1).
  do if (#d = 1). 
    compute mse=csum((y-(xzo*byzx))&**2)/(n-nv).
    compute resid(:,ncol(resid))=y-(xzo*byzx).
    compute covmat=mse*inv(t(xzo)*xzo).
    compute olscm=diag(covmat).
    compute sse = mse*(n-nv).
    compute sst = csum((y-(csum(y)/n))&**2).
    compute r2 = 1-(sse/sst).
    compute ar2 = 1-(mse/(sst/(n-1))).
    compute fr = ((n-nv)*r2)/((1-r2)*ncol(xz)).
    compute pfr = 1-fcdf(fr,ncol(xz),(n-nv)).
    do if (nc > 0).
      compute bcon = byzx((nv-nc+1):nv,1).
      compute bconse = sqrt(olscm((nv-nc+1):nv,1)).
    end if.
    compute byzx2se = sqrt(olscm(3:(nv-nc),1)).
    compute cprime = byzx(2,1).
    compute cprimese = sqrt(olscm(2,1)).
  end if.
  end if.
  compute indeff2 = (bzx&*byzx2).
  compute zs = (bzx&/bzxse)&*(byzx2&/byzx2se).
  compute temp = t({csum(indeff2); indeff2}).
  compute indeff(#d,:) = temp.
  do if (#d = 1).
    compute vs = nm(1:(nv-nc),1).
    print/title = "*****************************************************************".
    print/title = "Preacher and Hayes (2008) SPSS Macro for Multiple Mediation".
    print/title = "Written by Andrew F. Hayes, The Ohio State University".
    print/title = "http://www.comm.ohio-state.edu/ahayes/".
    print/title = "For details, see Preacher, K. J., & Hayes, A. F. (2008). Asymptotic".
    print/title = "and resampling strategies for assessing and comparing indirect effects".
    print/title = "in multiple mediator models. Behavior Research Methods, 40, 879-891.".
    print/title = "*****************************************************************".
    print vs/title = "Dependent, Independent, and Proposed Mediator Variables:"/rlabels = "DV =" 
    "IV = " "MEDS = "/format a8.
    do if (nc > 0).
      compute vs = nm((nv-nc+1):nv,1).
      print vs/title = "Statistical Controls:"/rlabels = "CONTROL="/format a8.
    end if.
    print n/title = "Sample size"/format F10.0.
    do if (ovals = 2).
    compute nmsd = {outv, "Analysis"}.
    print rcd/title = "Coding of binary DV for analysis:"/cnames = nmsd/format = F9.2.
    end if.
    compute nms = nm(3:(nv-nc),1).
    compute te = bzx&/bzxse. 
    compute df = n-2-nc.
    compute p = 2*(1-tcdf(abs(te), df)).
    compute bzxmat = {bzx, bzxse,te,p}.
    compute b(2:(nv-1-nc),1)=bzx. 
    compute se2 = bzxse&*bzxse.
    print bzxmat/title = "IV to Mediators (a paths)"/rnames = nms/clabels "Coeff" "se" "t" 
    "p"/format f9.4.
    compute te = byzx2&/byzx2se.
    compute df = n-nv.
    do if (ovals <> 2).
    compute p = 2*(1-tcdf(abs(te), df)).
    compute byzx2mat={byzx2, byzx2se, te, p}.
    print byzx2mat/title = "Direct Effects of Mediators on DV (b paths)"/rnames = nms/clabels 
    "Coeff" "se" "t" "p"/format f9.4.
    end if.
    do if (ovals = 2).
      compute wald = te&*te.
      compute p = 2*(1-cdfnorm(abs(te))).
      compute byzx2mat={byzx2, byzx2se, te, p, Wald}.
      print byzx2mat/title = "Direct Effects of Mediators on DV (b paths)"/rnames = nms/clabels 
    "Coeff" "se" "Z" "p" "Wald"/format f9.4.
    end if.
    compute te = byx&/byxse.
    compute df = n-2-nc.
    compute xnm = nm(2,1).
    do if (ovals <> 2).
    compute p = 2*(1-tcdf(abs(te), df)).
    compute byxmat = {byx, byxse, te, p}.
    print byxmat/title = "Total Effect of IV on DV (c path)"/rnames = xnm/clabels "Coeff" "se" 
    "t" "p"/format f9.4.
    end if.
    do if (ovals = 2).
    compute wald = te&*te.
    compute p = 2*(1-cdfnorm(abs(te))).
    compute byxmat = {byx, byxse, te, p, Wald}.
    print byxmat/title = "Total Effect of IV on DV (c path)"/rnames = xnm/clabels "Coeff" "se" 
    "Z" "p" "Wald"/format f9.4.
    end if.
    compute te = cprime&/cprimese.
    compute df = n-nv.
    do if (ovals <> 2).
    compute p = 2*(1-tcdf(abs(te), df)).
    compute cprimmat = {cprime, cprimese, te, p}.
    print cprimmat/title = "Direct Effect of IV on DV (c' path)"/rnames = xnm/clabels "Coeff" 
    "se" "t" "p"/format f9.4.
    end if.
    do if (ovals = 2).
    compute wald = te&*te.
    compute p = 2*(1-cdfnorm(abs(te))).
    compute cprimmat = {cprime, cprimese, te, p, Wald}.
    print cprimmat/title = "Direct Effect of IV on DV (c' path)"/rnames = xnm/clabels "Coeff" 
    "se" "Z" "p" "Wald"/format f9.4.
    end if.
    do if (nc > 0).
      compute df = n-nv.
      compute nms = nm((nv-nc+1):nv,1).
      compute te = bcon&/bconse.
      do if (ovals <> 2).
      compute p = 2*(1-tcdf(abs(te), df)).
      compute bconmat = {bcon, bconse,te,p}.
      print bconmat/title = "Partial Effect of Control Variables on DV"/rnames = nms/clabels 
    "Coeff" "se" "t" "p"/format f9.4.
      end if.
      do if (ovals = 2).
      compute wald = te&*te.
      compute p = 2*(1-cdfnorm(abs(te))).
      compute bconmat = {bcon, bconse,te,p, Wald}.
      print bconmat/title = "Partial Effect of Control Variables on DV"/rnames = nms/clabels 
    "Coeff" "se" "Z" "p" "Wald"/format f9.4.
      end if.
    end if.
    do if (ovals <> 2).
    compute dvms = {r2, ar2, fr, ncol(xz), (n-nv), pfr}.
    print dvms/title = "Model Summary for DV Model"/clabels "R-sq" "Adj R-sq" "F" "df1" "df2" 
    "p"/format F9.4.
    end if.
   do if (ovals = 2).
   compute LLdiff = LL3-LL2.
   compute mcF = LLdiff/LL3.
   compute cox = 1-exp(-LLdiff/n).
   compute nagel = cox/(1-exp(-(LL3)/n)).
   compute pf = {LL2, LLdiff, mcF, cox, nagel, n}.
   print pf/title = "Logistic Regression Summary for DV Model"/clabels = "-2LL" "Model LL" 
    "McFadden" "CoxSnell" "Nagelkrk" "n"/format F10.4.
   end if.
    do if (!normal <> 0 and nc = 0 and ovals <> 2).
      compute bmat = make((nv-nc),(nv-nc),0).
      compute bmat(2:(nv-nc-1),1) = bzx.
      compute bmat((nv-nc),2:(nv-nc-1))=t(byzx2).
      compute bmat((nv-nc),1) = cprime.
      compute imbinv = inv(ident(ncol(bmat))-bmat).
      compute imbtinv=inv(ident(ncol(bmat))-t(bmat)).
      compute resid(:,1)=x-(csum(x)/(n)).
      compute psi = sscp(resid)/(n).
      compute invpsi = inv(psi).
      compute ibpsiib = imbinv*psi*imbtinv.
      loop ic = 1 to ncol(info).
      loop ic2 = 1 to ncol(info).
      compute info(ic,ic2)=(n-1)*((imbinv(imat(ic2,4),imat(ic,1))*imbinv(imat(ic,2),imat(ic2,3)))+
    (ibpsiib(imat(ic2,4),imat(ic,2))*invpsi(imat(ic,1),imat(ic2,3)))).
      end loop.
      end loop.
      compute varcov = inv(info). 
      compute varcov = varcov(1:(2*(nv-nc-2)),1:(2*(nv-nc-2))).
      compute ses = diag(varcov).
      compute avar = ses(1:nrow(bzxse),1).
      compute bvar = ses((nrow(bzxse)+1):nrow(ses),1).
      do if ((nv-nc-2) > 1 and (!contrast = 1)).
        compute prws=make(((nv-nc-2)*(nv-nc-3)/2),1,0).
        compute prwse=prws.
        compute kk=1.
        loop ic = 1 to (nv-nc-3).
        loop ic2 = (ic+1) to (nv-nc-2).
        compute vf2 = ((byzx2(ic,1)**2)*varcov(ic,ic))-(2*byzx2(ic,1)*byzx2(ic2,1)*(varcov(ic,ic2)))
    .
        compute vf2=vf2+((byzx2(ic2,1)**2)*varcov(ic2,ic2))+((bzx(ic,1)**2)*(bvar(ic,1))).
        compute vf2=vf2-(2*bzx(ic,1)*bzx(ic2,1)*covmat((2+ic),(2+ic2)))+((bzx(ic2,1)**2)*(bvar(ic2,
    1))).
        compute cnt = indeff2(ic,1)-indeff2(ic2,1).
        compute prws(kk,1)=cnt.
        compute prwse(kk,1)=sqrt(vf2).
        compute kk=kk+1.
        end loop.
        end loop.
        compute cnam2 = cname(1:(kk-1),1).
      end if.
      compute dermat = {byzx2;bzx}.
      compute totse = sqrt(t(dermat)*varcov*dermat).
      compute specse = sqrt((byzx2&*byzx2)&*(avar)+(bzx&*bzx)&*(bvar)).
      compute specse = {totse; specse}.       
      compute specz = {csum(indeff2);indeff2}&/specse.
      compute ind22 = {csum(indeff2);indeff2}.
      compute nms = {"TOTAL";nm(3:(nv-nc),1)}.
      do if ((nv-nc-2) > 1 and (!contrast = 1)).
        compute ind22 = {ind22;prws}.
        compute specse = {specse;prwse}.
        compute specz = {specz;(prws&/prwse)}.
        compute nms = {nms;cnam2}.
      end if.
      compute pspec= 2*(1-cdfnorm(abs(specz))).
      compute spec = {ind22, specse, specz, pspec}.
      print/title = "******************************************************************".
      print/title = "           NORMAL THEORY TESTS FOR INDIRECT EFFECTS".
      print spec/title = "Indirect Effects of IV on DV through Proposed Mediators (ab "+
    "paths)"/rnames = nms/clabels "Effect" "se" "Z" "p"/format = f9.4.
    end if.
  end if.
end loop.
RELEASE dd, dat, dat2, x, y, m, imat, resid.
do if (btn > 1).
  compute nms = {"TOTAL"; nm(3:(nv-nc),1)}.
  do if ((nv-nc-2) > 1 and (!contrast = 1)).
    compute crst = make((n+1+btn),((nv-nc-2)*(nv-nc-3)/2),0).
    compute kk=1.
    loop ic = 2 to (nv-nc-2).
      loop ic2 = (ic+1) to (nv-nc-1).
        compute crst(:,kk)=indeff(:,ic)-indeff(:,ic2).
        compute kk=kk+1.
      end loop.
    end loop.
    compute indeff = {indeff,crst}.
    compute cnam2 = cname(1:(kk-1),1).
    compute nms = {nms;cnam2}.
  end if.
compute lvout = indeff(2:(n+1),:).
compute tdotm = csum(lvout)/n.
compute tm = (make(n,ncol(lvout),1))*mdiag(tdotm).
compute topa = csum((((n-1)/n)*(tm-lvout))&**3).
compute bota = 6*sqrt((csum((((n-1)/n)*(tm-lvout))&**2)&**3)).
compute ahat = topa&/bota.
compute indsam = t(indeff(1,:)).
compute boot = indeff((n+2):nrow(indeff),:).
compute mnboot = t(csum(boot)/btn).
compute se = (sqrt(((btn*cssq(boot))-(csum(boot)&**2))/((btn-1)*btn))).
loop #e = 1 to ncol(indeff).
  compute boottmp = boot(:,#e).
  compute boottmp(GRADE(boot(:,#e))) = boot(:,#e).
  compute boot(:,#e) = boottmp.
end loop.
compute xp = make((nrow(mnboot)+2),1,0).
loop i = 1 to (nrow(mnboot)+2).
  do if (i <= nrow(mnboot)).
    compute pv = (boot(:,i) < indsam(i,1)).
    compute pv = csum(pv)/btn.
  else.
    compute pv = zbca((i-nrow(mnboot)),1).
  end if.
  compute p = pv.
  do if (pv > .5).
    compute p = 1-pv.
  end if.
  compute y5=sqrt(-2*ln(p)).
  compute xp(i,1)=y5+((((y5*p4+p3)*y5+p2)*y5+p1)*y5+p0)/((((y5*q4+q3)*y5+q2)*y5+q1)*y5+q0).
  do if (pv <= .5).
    compute xp(i,1) = -xp(i,1).
  end if.
end loop.
compute bbb = nrow(mnboot).
compute zz = xp(1:bbb,1).
compute zlo = zz + ((zz+xp((bbb+1),1))&/(1-t(ahat)&*(zz+xp((bbb+1),1)))).
compute zup = zz + ((zz+xp((bbb+2),1))&/(1-t(ahat)&*(zz+xp((bbb+2),1)))).
compute ahat = 0.
compute zlobc = zz + ((zz+xp((bbb+1),1))&/(1-t(ahat)&*(zz+xp((bbb+1),1)))).
compute zupbc = zz + ((zz+xp((bbb+2),1))&/(1-t(ahat)&*(zz+xp((bbb+2),1)))).
compute zlo = cdfnorm(zlo).
compute zup = cdfnorm(zup).
compute zlobc = cdfnorm(zlobc).
compute zupbc = cdfnorm(zupbc).
compute blow = trunc(zlo*(btn+1)).
compute bhigh = trunc(zup*(btn+1))+1.
compute blowbc = trunc(zlobc*(btn+1)).
compute bhighbc = trunc(zupbc*(btn+1))+1.
compute lowbca = make(nrow(blow),1,0).
compute upbca = lowbca.
loop i = 1 to nrow(blow).
  do if (blow(i,1) < 1).
    compute blow(i,1) = 1.
  end if.
  compute lowbca(i,1)=boot(blow(i,1),i).
  do if (bhigh(i,1) > btn).
    compute bhigh(i,1) = btn.
  end if.
  compute upbca(i,1)=boot(bhigh(i,1),i).
end loop.
compute lowbc = make(nrow(blow),1,0).
compute upbc = lowbca.
loop i = 1 to nrow(blowbc).
  do if (blowbc(i,1) < 1).
    compute blowbc(i,1) = 1.
  end if.
  compute lowbc(i,1)=boot(blowbc(i,1),i).
  do if (bhighbc(i,1) > btn).
    compute bhighbc(i,1) = btn.
  end if.
  compute upbc(i,1)=boot(bhighbc(i,1),i).
end loop.
print/title = "*****************************************************************".
print/title = "           BOOTSTRAP RESULTS FOR INDIRECT EFFECTS".
compute res = {indsam, mnboot,(mnboot-indsam), t(se)}.
print res/title = "Indirect Effects of IV on DV through Proposed Mediators (ab paths)"/rnames = 
    nms/clabels "Data" "Boot" "Bias" "SE"/format f9.4.
compute lowperc = boot(blowp,:).
compute upperc = boot(bhighp,:).
compute ci = {lowbca, upbca}.
do if (!bca <> 0).
  print ci/title = "Bias Corrected and Accelerated Confidence Intervals"/rnames = nms/clabels 
    "Lower" "Upper"/format F9.4.
end if.
do if (!bc <> 0).
  compute ci = {lowbc, upbc}.
  print ci/title = "Bias Corrected Confidence Intervals"/rnames = nms/clabels "Lower" 
    "Upper"/format F9.4.
end if.
do if (!percent <> 0).
  compute ci = {t(lowperc), t(upperc)}.
  print ci/title = "Percentile Confidence Intervals"/rnames = nms/clabels "Lower" "Upper"/format 
    F9.4.
end if.
print/title = "*****************************************************************".
print conf/title = "Level of Confidence for Confidence Intervals:".
print btn/title = "Number of Bootstrap Resamples:".
end if.
do if ((nv-nc-2) > 1 and (!contrast = 1) and ((!normal = 1 and nc = 0) OR btn > 999))).
print/title = "*****************************************************************".
print/title = "  INDIRECT EFFECT CONTRAST DEFINITIONS: Ind_Eff1 MINUS Ind_Eff2".
compute kk=1.
compute prwsv=make(((nv-nc-2)*(nv-nc-3)/2),2,0).
 loop ic = 1 to (nv-nc-3).
        loop ic2 = (ic+1) to (nv-nc-2).
          compute prwsv(kk,1)=nm(ic+2,1).
          compute prwsv(kk,2)=nm(ic2+2,1).
          compute kk=kk+1.
       end loop.
end loop.
compute prwsv = {cnam2, prwsv}.
print prwsv/title = " "/clabels = "Contrast" "IndEff_1" "IndEff_2"/format A9.
end if.
Print/title = "********************************* NOTES **********************************".
do if (btn = 1 or !normal=1).
Print/title = "Bootstrap confidence intervals are preferred to normal theory tests for". 
print/title = "inference about indirect effects.  See Hayes, A. F. (2009). Beyond Baron"/space=0.
print/title =  "and Kenny: Statistical mediation analysis in the new millennium."/space=0.
Print/title = "Communication Monographs, 76, 408-420, or Hayes, A. F. (2013). Introduction "+
    "to"/space=0.
print/title = "mediation, moderation, and conditional process analysis: A regression-based"/space=0.    
print/title = "approach. New York: The Guilford Press"/space=0.
end if.
do if (bdbp > 0).
print/title = "*****************************************************************".
print/title = "WARNING: SOME BOOTSTRAP MATRICES WERE SINGULAR".
print/title = "SINGULAR MATRICES WERE REPLACED DURING RESAMPLING".
print bdbp/title = "Number of singular bootstrap samples replaced:".
end if.
   do if (ovals = 2).
   print/title = "*****************************************************************".
   print/title = "NORMAL THEORY TESTS NOT AVAILABLE FOR MODELS WITH DICHOTOMOUS OUTCOMES".
   do if (!boot = 0).
   print/title = "To obtain indirect effects, request bootstrapping".
   end if.
   end if.
   do if (nc > 0 and !normal = 1).
   print/title = "NORMAL THEORY TESTS NOT AVAILABLE IN MODELS WITH COVARIATES".
   do if (!boot = 0).
   print/title = "To obtain indirect effects, request bootstrapping".
   end if.
   end if.
END MATRIX.
RESTORE.
!ENDDEFINE.
INDIRECT y = SJS/x = Gender/m = SOI_avg /boot = 1000/conf = 95/normal = 0/contrast = 0/percent = 
    0/bc = 1/bca = 0.


