using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.Mvc;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ElefantesBlancos.Controllers
{
    public class DownloadFileActionResult : ActionResult
    {

          public GridView ExcelGridView { get; set; }
        public string fileName { get; set; }


        public DownloadFileActionResult(GridView gv, string pFileName)
        {

            ExcelGridView = gv;

            fileName = pFileName;

        }



        public override void ExecuteResult(ControllerContext context)
        {

            HttpContext curContext = HttpContext.Current;

            curContext.Response.Clear();

            curContext.Response.AddHeader("content-disposition", "attachment;filename=" + fileName);

            curContext.Response.Charset = "";

            curContext.Response.Cache.SetCacheability(HttpCacheability.NoCache);

            curContext.Response.ContentType = "application/vnd.ms-excel";

            StringWriter sw = new StringWriter();
            HtmlTextWriter htw = new HtmlTextWriter(sw);
            ExcelGridView.RenderControl(htw);
            
            byte[] byteArray = Encoding.ASCII.GetBytes(sw.ToString());

            MemoryStream s = new MemoryStream(byteArray);

            StreamReader sr = new StreamReader(s, Encoding.ASCII);



            curContext.Response.Write(sr.ReadToEnd());

            curContext.Response.End();

        }
    }
}