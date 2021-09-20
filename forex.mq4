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
//+------------------------------------------------------------------+