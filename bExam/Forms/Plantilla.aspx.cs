using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Security.Principal;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace bExam.Forms
{
    public partial class Plantilla : System.Web.UI.Page
    {
        readonly SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["conexion"].ConnectionString);
        public static string sID = "-1";
        public static string sOpc = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                if (Request.QueryString["id"] != null)
                {
                    sID = Request.QueryString["id"].ToString();
                    CargarDatos();
                }

                if (Request.QueryString["op"] != null)
                {
                    sOpc = Request.QueryString["op"].ToString();

                    switch (sOpc)
                    {
                        case "C":
                            this.lbltitulo.Text = "Agregar registro";
                            this.btnNew.Visible = true;
                            break;
                        case "R":
                            this.lbltitulo.Text = "Consultar registro";
                            break;
                        case "U":
                            this.lbltitulo.Text = "Actualizar registro";
                            this.btnUpdate.Visible = true;
                            break;
                        case "D":
                            this.lbltitulo.Text = "Eliminar registro";
                            this.btnDelete.Visible = true;
                            break;
                    }
                }
            }
        }

        void CargarDatos()
        {
            con.Open();
            SqlDataAdapter da = new SqlDataAdapter("spConsultar", con);
            da.SelectCommand.CommandType = CommandType.StoredProcedure;
            da.SelectCommand.Parameters.Add("@Id", SqlDbType.Int).Value = sID;
            DataSet ds = new DataSet();
            ds.Clear();
            da.Fill(ds);
            DataTable dt = ds.Tables[0];
            DataRow row = dt.Rows[0];
            txtName.Text = row[1].ToString();
            txtDescription.Text = row[2].ToString();
            con.Close();
        }
        protected void btnNew_Click(object sender, EventArgs e)
        {
            try
            {
                //string msg = txtDescription.Value;
                SqlCommand cmd = new SqlCommand("spAgregar", con);
                con.Open();
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add("@Id", SqlDbType.Int).Value = 0;
                cmd.Parameters.Add("@Nombre", SqlDbType.VarChar).Value = txtName.Text;
                cmd.Parameters.Add("@Descripcion", SqlDbType.VarChar).Value = txtDescription.Text;
                cmd.ExecuteNonQuery();
                con.Close();
                Response.Redirect("Index.aspx");
            }
            catch(Exception ex)
            {
                ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "err_msg", "errorAlert('Error','Ha ocurrido un error al memomento de guardar, intentalo mas tarde');", true);
            }
            
        }

        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            try
            {
                SqlCommand cmd = new SqlCommand("spActualizar", con);
                con.Open();
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add("@Id", SqlDbType.Int).Value = sID;
                cmd.Parameters.Add("@Nombre", SqlDbType.VarChar).Value = txtName.Text;
                cmd.Parameters.Add("@Descripcion", SqlDbType.VarChar).Value = txtDescription.Text;
                cmd.ExecuteNonQuery();
                con.Close();
                Response.Redirect("Index.aspx");
            }
            catch (Exception ex)
            {
                ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "err_msg", "errorAlert('Error','Ha ocurrido un error al memomento de actualizar, intentalo mas tarde');", true);
            }
        }

        protected void btnDelete_Click(object sender, EventArgs e)
        {
            try
            {
                SqlCommand cmd = new SqlCommand("spEliminar", con);
                con.Open();
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add("@Id", SqlDbType.Int).Value = sID;
                cmd.ExecuteNonQuery();
                con.Close();
                Response.Redirect("Index.aspx");
            }
            catch(Exception ex)
            {
                ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "err_msg", "errorAlert('Error','Ha ocurrido un error al memomento de eliminar, intentalo mas tarde');", true);
        }
    }

        protected void btnBack_Click(object sender, EventArgs e)
        {
            Response.Redirect("Index.aspx");
        }
    }
}