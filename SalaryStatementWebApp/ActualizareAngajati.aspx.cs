using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;
using System.Configuration;

namespace SalaryStatementWebApp
{
    public partial class ActualizareAngajati : System.Web.UI.Page
    {
        private string connectionString = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadEmployees();
                editPanel.Visible = false; // Hide edit form initially
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
            rptEmployees.DataSource = dt;
            rptEmployees.DataBind();
            editPanel.Visible = false; // Hide edit form if visible
        }

        protected void rptEmployees_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "EditEmployee")
            {
                int nrCrt = Convert.ToInt32(e.CommandArgument);
                hfEmployeeId.Value = nrCrt.ToString(); // Store employee ID

                string query = "SELECT * FROM Angajati WHERE nr_crt = @nrCrt";
                var parameters = new SqlParameter[] { new SqlParameter("@nrCrt", nrCrt) };
                var dt = ExecuteQuery(query, parameters);

                if (dt.Rows.Count > 0)
                {
                    DataRow row = dt.Rows[0];
                    txtNume.Text = row["Nume"].ToString();
                    txtPrenume.Text = row["Prenume"].ToString();
                    txtFunctie.Text = row["Functie"].ToString();
                    txtSalarBaza.Text = row["salar_baza"].ToString();
                    txtSporPercent.Text = row["spor_percent"].ToString();
                    txtPremiiBrute.Text = row["premii_brute"].ToString();

                    editPanel.Visible = true; // Show edit form
                }
            }
        }

        protected void btnUpdateEmployee_Click(object sender, EventArgs e)
        {
            try
            {
                int nrCrt = Convert.ToInt32(hfEmployeeId.Value);
                string nume = txtNume.Text.Trim();
                string prenume = txtPrenume.Text.Trim();
                string functie = txtFunctie.Text.Trim();
                decimal salarBaza = decimal.Parse(txtSalarBaza.Text.Trim());
                decimal sporPercent = decimal.Parse(txtSporPercent.Text.Trim());
                decimal premiiBrute = decimal.Parse(txtPremiiBrute.Text.Trim());
                string filePath = string.Empty;

                string query = "UPDATE Angajati SET Nume = @Nume, Prenume = @Prenume, Functie = @Functie, salar_baza = @SalarBaza, spor_percent = @SporPercent, premii_brute = @PremiiBrute WHERE nr_crt = @NrCrt";
                var parameters = new SqlParameter[] {
                    new SqlParameter("@Nume", nume),
                    new SqlParameter("@Prenume", prenume),
                    new SqlParameter("@Functie", functie),
                    new SqlParameter("@SalarBaza", salarBaza),
                    new SqlParameter("@SporPercent", sporPercent),
                    new SqlParameter("@PremiiBrute", premiiBrute),
                    new SqlParameter("@NrCrt", nrCrt)
                };

                ExecuteNonQuery(query, parameters);
                LoadEmployees(); // Refresh data
                editPanel.Visible = false; // Hide edit form
            }
            catch (Exception ex)
            {
                lblMessage.Text = "Eroare: " + ex.Message;
            }
        }

        protected void btnCancelEdit_Click(object sender, EventArgs e)
        {
            editPanel.Visible = false; // Hide the edit form
        }

        private DataTable ExecuteQuery(string query, SqlParameter[] parameters = null)
        {
            DataTable dt = new DataTable();
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlCommand cmd = new SqlCommand(query, connection))
                {
                    if (parameters != null) cmd.Parameters.AddRange(parameters);
                    using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                    {
                        connection.Open();
                        da.Fill(dt);
                    }
                }
            }
            return dt;
        }

        private void ExecuteNonQuery(string query, SqlParameter[] parameters)
        {
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlCommand cmd = new SqlCommand(query, connection))
                {
                    cmd.Parameters.AddRange(parameters);
                    connection.Open();
                    cmd.ExecuteNonQuery();
                }
            }
        }

        private void LoadEmployees()
        {
            string query = "SELECT * FROM Angajati";
            var dt = ExecuteQuery(query);

            rptEmployees.DataSource = dt;
            rptEmployees.DataBind();
        }
    }
}
