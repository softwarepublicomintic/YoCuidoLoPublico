//------------------------------------------------------------------------------
// <auto-generated>
//    This code was generated from a template.
//
//    Manual changes to this file may cause unexpected behavior in your application.
//    Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace ElefantesBlancosDatos.Models
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    
    public partial class stra_motivos_elefante
    {
        public stra_motivos_elefante()
        {
            this.stra_elefantes = new HashSet<stra_elefantes>();
        }


        [Key]
        [Display(Name = "Identificador")]
        public int id_stra_motivo_elefante { get; set; }
           [Required(ErrorMessage = "El nombre del par�metro es obligatorio ")]
        [StringLength(100, ErrorMessage = "M�ximo n�mero de car�cteres ha sobrepasado")]
        public string motivo { get; set; }
    
        public  ICollection<stra_elefantes> stra_elefantes { get; set; }
    }
}
