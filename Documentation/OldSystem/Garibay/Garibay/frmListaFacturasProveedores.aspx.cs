﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Garibay
{
    public partial class frmListaFacturasProveedores : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected string GetFacturaURL(string id)
        {
            return "~/frmFacturasDeCompra.aspx" + Utils.GetEncriptedQueryString("FacturaDeCompraID=" + id);
        }
    }
}
