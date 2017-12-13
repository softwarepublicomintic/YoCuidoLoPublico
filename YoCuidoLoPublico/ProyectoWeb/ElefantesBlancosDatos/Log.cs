using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ElefantesBlancosDatos
{
    public static class Log
    {
        public static void WriteLog(string logFile, string text)
        {
            string strLogfile = "";
            strLogfile = logFile + "\\Log" + DateTime.Today.ToString("yyyyMMdd") + ".txt"; 
            StringBuilder message = new StringBuilder();
            message.AppendLine(DateTime.Now.ToString());
            message.AppendLine(text);
            message.AppendLine("=========================================");

            System.IO.File.AppendAllText(strLogfile, message.ToString());
        }

    }
}
