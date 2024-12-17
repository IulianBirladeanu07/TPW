using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.UI.WebControls;

namespace SalaryStatementWebApp
{
    public partial class StergereAngajati : System.Web.UI.Page
    {
        private string connectionString = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadEmployees(); // Load employees on first visit
            }
        }

        protected void btnSearchEmployee_Click(object sender, EventArgs e)
        {
            string searchName = txtSearchName.Text.Trim();
            string query = "SELECT * FROM Angajati WHERE Nume LIKE @searchName OR Prenume LIKE @searchName";
            var parameters = new SqlParameter[] {
                new SqlParameter("@searchName", "%" + searchName + "%")
            };

            var dt = ExecuteQuery(query, parameters);
            if (dt.Rows.Count > 0)
            {
                rptEmployees.DataSource = dt;
                rptEmployees.DataBind();
                lblMessage.Text = ""; // Clear any previous messages
            }
            else
            {
                lblMessage.Text = "Nu s-au găsit angajați care să corespundă căutării.";
                rptEmployees.DataSource = null; // Clear the repeater
                rptEmployees.DataBind();
            }
        }

        protected void rptEmployees_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "DeleteEmployee")
            {
                string employeeId = e.CommandArgument.ToString();
                ClientScript.RegisterStartupScript(this.GetType(), "showDeleteConfirmation",
                    $"showDeleteConfirmation('{employeeId}');", true);
            }
        }

        protected void btnConfirmDelete_Click(object sender, EventArgs e)
        {
            string employeeId = hfEmployeeId.Value;
            string query = "DELETE FROM Angajati WHERE nr_crt = @NrCrt";
            var parameters = new SqlParameter[] { new SqlParameter("@NrCrt", int.Parse(employeeId)) };

            ExecuteNonQuery(query, parameters);

            // Display success message and refresh the list
            lblMessage.Text = "Angajatul a fost șters cu succes.";

            // Reload the employees after deletion
            ClientScript.RegisterStartupScript(this.GetType(), "refreshList", "refreshEmployeeList();", true);

            // Hide the confirmation panel
            ClientScript.RegisterStartupScript(this.GetType(), "hideDeleteConfirmation",
                "hideDeleteConfirmation();", true);
        }

        protected void btnCancelDelete_Click(object sender, EventArgs e)
        {
            ClientScript.RegisterStartupScript(this.GetType(), "hideDeleteConfirmation",
                "hideDeleteConfirmation();", true); // Hide the delete panel
        }

        private void LoadEmployees()
        {
            string query = "SELECT * FROM Angajati";
            var dt = ExecuteQuery(query);
            rptEmployees.DataSource = dt;
            rptEmployees.DataBind();
        }

        private DataTable ExecuteQuery(string query, SqlParameter[] parameters = null)
        {
            DataTable dt = new DataTable();
            try
            {
                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    using (SqlCommand cmd = new SqlCommand(query, connection))
                    {
                        if (parameters != null)
                            cmd.Parameters.AddRange(parameters);

                        connection.Open();
                        SqlDataAdapter adapter = new SqlDataAdapter(cmd);
                        adapter.Fill(dt);
                    }
                }
            }
            catch (Exception ex)
            {
                lblMessage.Text = "Eroare la interogare: " + ex.Message;
            }
            return dt;
        }

        private void ExecuteNonQuery(string query, SqlParameter[] parameters = null)
        {
            try
            {
                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    using (SqlCommand cmd = new SqlCommand(query, connection))
                    {
                        if (parameters != null)
                            cmd.Parameters.AddRange(parameters);

                        connection.Open();
                        cmd.ExecuteNonQuery();
                    }
                }
            }
            catch (Exception ex)
            {
                lblMessage.Text = "Eroare la executarea comenzii: " + ex.Message;
            }
        }
    }
}
