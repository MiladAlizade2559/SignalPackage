//+------------------------------------------------------------------+
//|                                                SignalPackage.mqh |
//|                                   Copyright 2025, Milad Alizade. |
//|                   https://www.mql5.com/en/users/MiladAlizade2559 |
//+------------------------------------------------------------------+
#property copyright "Copyright 2025, Milad Alizade."
#property link      "https://www.mql5.com/en/users/MiladAlizade2559"
#property version   "1.00"
//+------------------------------------------------------------------+
//| Includes                                                         |
//+------------------------------------------------------------------+
#include <Base/CBase.mqh>
#include <Signal/Signal.mqh>
//+------------------------------------------------------------------+
//| Class CSignalPackage                                             |
//| Usage: Controls work with multiple signals                       |
//+------------------------------------------------------------------+
class CSignalPackage : public CBase
   {
protected:
    ulong            m_id;                         // id number
    double           m_profit_opened;              // profit positions opened
    double           m_profit_closed ;             // profit positions closed
    CSignal          m_signals[];                  // signals array
    CSignal          m_positions[];                // positions array
    CSignal          m_history[];                  // history array
    int              m_signals_total;              // signals total
    int              m_positions_total;            // positions total
    int              m_history_total;              // history total
    CTrade           *m_trade;                     // trade object
protected:
    //--- Functions for controlling data variables
    int              Move(CSignal &dst_settings[],CSignal &src_settings[],const int src_start);
public:
                     CSignalPackage(CTrade *obj,const int id);
                    ~CSignalPackage(void);
    //--- Functions for controlling data variables
    virtual int      Variables(const ENUM_VARIABLES_FLAGS flag,string &array[],const bool compact_objs = false);
    void             Id(const ulong id)            {m_id = id;                   }  // set id
    ulong            Id(void)                      {return(m_id);                }  // get id
    double           ProfitOpened(void)            {return(m_profit_opened);     }  // get profit positions opened
    double           ProfitClosed(void)            {return(m_profit_closed);     }  // get profit positions closed
    int              Signals(CSignal &array[]);
    int              Positions(CSignal &array[]);
    int              History(CSignal &array[]);
   };
//+------------------------------------------------------------------+
//| Constructor                                                      |
//+------------------------------------------------------------------+
CSignalPackage::CSignalPackage(CTrade *obj,const int id) : m_id(id)
   {
    m_trade = obj;
   }
//+------------------------------------------------------------------+
//| Destructor                                                       |
//+------------------------------------------------------------------+
CSignalPackage::~CSignalPackage(void)
   {
   }
//+------------------------------------------------------------------+
//| Setting variables                                                |
//+------------------------------------------------------------------+
int CSignalPackage::Variables(const ENUM_VARIABLES_FLAGS flag,string &array[],const bool compact_objs = false)
   {
    CBase::Variables(flag,array,compact_objs);
    _ulong(m_id);
    _double(m_profit_opened);
    _double(m_profit_closed);
    _class_array(m_signals);
    _class_array(m_positions);
    _class_array(m_history);
    _int(m_signals_total);
    _int(m_positions_total);
    _int(m_history_total);
    return(CBase::Variables(array));
   }
//+------------------------------------------------------------------+
//| Move signal struct                                               |
//+------------------------------------------------------------------+
int CSignalPackage::Move(CSignal &dst_settings[],CSignal &src_settings[],const int src_start)
   {
//--- check src start
    if(src_start >= ArraySize(src_settings))
        return(-1);
//--- resize dst settings array
    int size = ArraySize(dst_settings);
    ArrayResize(dst_settings,size + 1);
//--- set value to dst settings array from src settings array
    dst_settings[size] = src_settings[src_start];
    ArrayRemove(src_settings,src_start,1);
    return(size);
   }
//+------------------------------------------------------------------+
//| Get sub signals array                                            |
//+------------------------------------------------------------------+
int CSignalPackage::Signals(CSignal &array[])
   {
//--- resize array
    ArrayResize(array,m_signals_total);
//--- set sub signals to array
    for(int i = 0; i < m_signals_total; i++)
       {
        array[i] = m_signals[i];
       }
    return(m_signals_total);
   }
//+------------------------------------------------------------------+
//| Get sub positions array                                          |
//+------------------------------------------------------------------+
int CSignalPackage::Positions(CSignal &array[])
   {
//--- resize array
    ArrayResize(array,m_positions_total);
//--- set sub positions to array
    for(int i = 0; i < m_positions_total; i++)
       {
        array[i] = m_positions[i];
       }
    return(m_positions_total);
   }
//+------------------------------------------------------------------+
//| Get sub history array                                            |
//+------------------------------------------------------------------+
int CSignalPackage::History(CSignal &array[])
   {
//--- resize array
    ArrayResize(array,m_history_total);
//--- set sub histroy to array
    for(int i = 0; i < m_history_total; i++)
       {
        array[i] = m_history[i];
       }
    return(m_history_total);
   }
//+------------------------------------------------------------------+
