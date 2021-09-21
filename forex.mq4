//+------------------------------------------------------------------+
//|                                                        forex.mq4 |
//|                        Copyright 2021, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2021, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict
//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
//--- create timer
   EventSetTimer(60);
//---
   return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {
//--- destroy timer
   EventKillTimer();
   
  }
//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick()
  {
//---
   
  }
//+------------------------------------------------------------------+
//| Timer function                                                   |
//+------------------------------------------------------------------+
void OnTimer()
  {
//---
   
  }
//+------------------------------------------------------------------+
//| Tester function                                                  |
//+------------------------------------------------------------------+
double OnTester()
  {
//---
   double ret=0.0;
//---

//---
   return(ret);
  }
//+------------------------------------------------------------------+
//| ChartEvent function                                              |
//+------------------------------------------------------------------+
void OnChartEvent(const int id,
                  const long &lparam,
                  const double &dparam,
                  const string &sparam)
  {
//---
   
  }
  void OnStart()
  {
  Alert("getlength is"+getCandleLength(1));
  Alert("volume"+Volume[1]);
  }
//+------------------------------------------------------------------+
//| Chartist Analyser function                                              |
//+------------------------------------------------------------------+
int getCandleType(int candlePlace)
{
//---
int ret ;
double op,cl ;
op = Open[candlePlace] ;
cl = Close[candlePlace] ;
if (op<cl)
{ ret = 1 ; }
else if (op == cl)
{ ret = 0 ; }
else
{ ret = -1 ; }
return ret;
}

int getCandleLength(int candlePlace)
{
//---
double op,cl,ret ;
op = Open[candlePlace] ;
cl = Close[candlePlace] ;
if (op < cl){ ret = cl-op ; }
else { ret = op-cl ; }
return ret ;
}
bool isBullishUnderneckLine(int candlePlace,double lengthDiff)
{
//---
bool ret = false ;
double cl1,cl2 ;
int candleBefore = candlePlace++ ;
cl1 = Close[candleBefore];
cl2=Close[candlePlace];
if ((getCandleType(candlePlace) == getCandleType(candleBefore))||(getCandleType(candlePlace) != -1)||(cl1 >= cl2)) {}
else { if (getCandleLength(candleBefore) - getCandleLength(candlePlace) >= lengthDiff) { ret == true ; } }
return ret ;
}
bool isBearishUnderneckLine(int candlePlace,double lengthDiff)
{
//---
bool ret = false ;
double cl1,cl2 ;
int candleBefore = candlePlace++ ;
cl1 = Close[candleBefore];
cl2 = Close[candlePlace];
if ((getCandleType(candlePlace) == getCandleType(candleBefore))||(getCandleType(candlePlace) != 1)||(cl1 <= cl2)) {}
else { if (getCandleLength(candleBefore) - getCandleLength(candlePlace) >= lengthDiff) { ret == true ; } }
return ret ;
}
bool isBullishGap(int candlePlace)
{
//---
bool ret = false ;
double cl,low ;
int candleBefore = candlePlace++ ;
cl = Close[candleBefore] ;
low = Low[candlePlace] ;
if (( cl < low )&&( getCandleType(candlePlace) == 1 )&&(getCandleType(candleBefore == 1 ))) { ret = true ; }
return ret;
}
bool isBearishGap(int candlePlace)
{
//---
bool ret = false ;
double cl,high ;
int candleBefore = candlePlace++ ;
cl = Close[candleBefore] ;
high = High[candlePlace] ;
if (( cl > high )&&( getCandleType(candlePlace) == -1 )&&( getCandleType(candleBefore == -1 ))) { ret = true ; }
return ret;
}

double getPercentage(int candle)
{
double full=High[candle]-Low[candle];
return (getCandleLength(candle)*100)/full;
}


double getValue(int candle,double percentage)
{
double full=High[candle]-Low[candle];
return (percentage*full)/100;
}

bool isInMargin(int candle,double marginPercentage)
{
   bool ret=false;
   double diffLength,margin,errorMargin;
   margin=getValue(candle,marginPercentage);
   errorMargin=getValue(candle,5);
   if(getCandleType(candle)==1)
   {
      diffLength=High[candle]-Close[candle];
   }
   else
   {
   diffLength=High[candle]-Open[candle];
   }
   if((margin+errorMargin>=diffLength)&&(diffLength>=margin-errorMargin)){ret=true;}
   return ret;
}

bool verify(int candle,double percentage,double marginPercentage){
   bool ret=false;
   if((getPercentage(candle)>=percentage-5)&&(percentage+5>=getPercentage(candle))&&(isInMargin(candle,marginPercentage)))
   {
    ret=true;
   }
   return ret;
}

bool isPressure(int candle)
{
   return verify(candle,80,20);
}

bool isHammer(int candle)
{
   return verify(candle,25,0);
}

bool isReverseHammer(int candle)
{
   return verify(candle,25,75);
}

bool isMarobozu(int candle)
{
   return verify(candle,100,0);
}

bool isApproximative(double v1,double v2,double margin)
{
   bool ret=false;
   if((v1>=v2-margin)&&(v2+margin>=v1))
   {
      ret=true;
   }
   return ret;
}

bool wouldGoDown(int candle)//farany
{
   return true;
}


//+------------------------------------------------------------------+