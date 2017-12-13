using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace ElefantesBlancosDatos.Models
{
    public class ImageModels
    {
        public int Id { get; set; }
        public int? Idpadre { get; set; }
        public string Route { get; set; }
        public string Tittle { get; set; }
        public string Description { get; set; }
        public bool Isprincipal { get; set; }
    }

    public class ListImageModels
    {
        public List<ImageModels> ImageShort { get; set; }
        public List<ImageModels> ImageBig { get; set; }
    }
}