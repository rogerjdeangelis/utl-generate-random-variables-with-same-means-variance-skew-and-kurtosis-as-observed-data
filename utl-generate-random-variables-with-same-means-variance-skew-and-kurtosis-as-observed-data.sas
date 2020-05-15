%let pgm=utl-generate-random-variables-with-same-means-variance-skew-and-kurtosis-as-observed-data;                       
                                                                                                                          
Generate 100,000 random variables with the same means variances skewness and kurtosis as observed data                    
                                                                                                                          
Looks like a solid package.                                                                                               
                                                                                                                          
Benchmarks (just the genneration process)                                                                                 
                                                                                                                          
                   seconds                                                                                                
                                                                                                                          
   Vanilla CRAN R    6.1                                                                                                  
   MS Open R         6.4  (theading overhead?)                                                                            
                                                                                                                          
  Creating output that SAS can input and process                                                                          
  Write(in R) and read binary(in SAS) 100,000 floats and run means and corr on R data                                     
                                                                                                                          
   Vanilla CRAN R    6.8                                                                                                  
                                                                                                                          
StackOverflow                                                                                                             
https://tinyurl.com/y95uwmeg                                                                                              
https://stackoverflow.com/questions/61780982/issues-with-simulating-correlated-random-variables                           
                                                                                                                          
Chuck P Profile                                                                                                           
https://stackoverflow.com/users/9190034/chuck-p                                                                           
                                                                                                                          
Amazing solid package                                                                                                     
https://tinyurl.com/ybagyqn9                                                                                              
https://cran.r-project.org/web/packages/SimMultiCorrData/SimMultiCorrData.pdf                                             
                                                                                                                          
*_                   _                                                                                                    
(_)_ __  _ __  _   _| |_                                                                                                  
| | '_ \| '_ \| | | | __|                                                                                                 
| | | | | |_) | |_| | |_                                                                                                  
|_|_| |_| .__/ \__,_|\__|                                                                                                 
        |_|                                                                                                               
;                                                                                                                         
                                                                                                                          
options validvarname=upcase;                                                                                              
libname sd1 "d:/sd1";                                                                                                     
data sd1.have;                                                                                                            
   set sashelp.heart(keep=diastolic systolic);                                                                            
run;quit;                                                                                                                 
                                                                                                                          
                                                                                                                          
SD1.HAVE total obs=5,209                                                                                                  
                                                                                                                          
 DIASTOLIC    SYSTOLIC                                                                                                    
                                                                                                                          
     78          124                                                                                                      
     92          144                                                                                                      
     90          170                                                                                                      
     80          128                                                                                                      
     76          110                                                                                                      
   ...                                                                                                                    
                                                                                                                          
*            _               _                                                                                            
  ___  _   _| |_ _ __  _   _| |_                                                                                          
 / _ \| | | | __| '_ \| | | | __|                                                                                         
| (_) | |_| | |_| |_) | |_| | |_                                                                                          
 \___/ \__,_|\__| .__/ \__,_|\__|                                                                                         
                |_|                                                                                                       
 _  ___   ___   ___   ___   ___                                                                                           
/ |/ _ \ / _ \ / _ \ / _ \ / _ \                                                                                          
| | | | | | | | | | | | | | | | |                                                                                         
| | |_| | |_| | |_| | |_| | |_| |                                                                                         
|_|\___/ \___( )___/ \___/ \___/                                                                                          
             |/                                                                                                           
;                                                                                                                         
                                                                                                                          
proc means data=sd1.have n mean var skewness kurtosis;                                                                    
run;quit;                                                                                                                 
                                                                                                                          
Variable          N            Mean        Variance        Skewness        Kurtosis                                       
SYSTOLIC     100000     137.0087991     566.9428638       1.5196159       4.4452164                                       
DIASTOLIC    100000      85.4029635     168.3698436       0.8923569       1.8361421                                       
                                                                                                                          
proc corr data=sd1.have;                                                                                                  
run;quit;                                                                                                                 
                                                                                                                          
               SYSTOLIC      DIASTOLIC                                                                                    
                                                                                                                          
SYSTOLIC        1.00000        0.79992                                                                                    
DIASTOLIC       0.79992        1.00000                                                                                    
                                                                                                                          
                                                                                                                          
*                                                                                                                         
 _ __  _ __ ___   ___ ___  ___ ___                                                                                        
| '_ \| '__/ _ \ / __/ _ \/ __/ __|                                                                                       
| |_) | | | (_) | (_|  __/\__ \__ \                                                                                       
| .__/|_|  \___/ \___\___||___/___/                                                                                       
|_|                                                                                                                       
;                                                                                                                         
                                                                                                                          
* Note bivariate inputs (same as sashelp.heart                                                                            
                                                                                                                          
                                                                                                                          
                SYSTOLIC  DIASTOLIC                                                                                       
                                                                                                                          
   means          137       85.4                                                                                          
   variances      563        168                                                                                          
   skews         1.48       0.88                                                                                          
   skurts        4.23       1.85                                                                                          
                                                                                                                          
  cor                                                                                                                     
      1     0.8                                                                                                           
    0.8,      1                                                                                                           
                                                                                                                          
                                                                                                                          
%utl_submit_r64('                                                                                                         
library(SimMultiCorrData);                                                                                                
Sim1<-SimMultiCorrData::rcorrvar(n = 100000, k_cat = 0, k_cont = 2, method = "Fleishman",                                 
 means = c(137,85.4), vars = c(563,168), skews = c(1.48, .88), skurts = c(4.23,1.85),                                     
 rho = matrix(c(1,.8,.8,1), 2, 2));                                                                                       
 want<-as.vector(t(Sim1$continuous_variables));                                                                           
 head(want);                                                                                                              
 str(want);                                                                                                               
 outbin <- "f:/bin/want.bin";                                                                                             
 writeBin(want, file(outbin, "wb"), size=8);                                                                              
');                                                                                                                       
                                                                                                                          
filename bin "f:/bin/want.bin" lrecl=8 recfm=f;                                                                           
data want;                                                                                                                
 infile bin;                                                                                                              
 input systolic  rb8.  @@;                                                                                                
 input diastolic rb8.  @@;                                                                                                
 output;                                                                                                                  
run;quit;                                                                                                                 
                                                                                                                          
proc corr data=want;                                                                                                      
run;quit;                                                                                                                 
                                                                                                                          
proc means data=want n mean var skewness kurtosis;                                                                        
run;quit;                                                                                                                 
                                                                                                                          
                                                                                                                          
