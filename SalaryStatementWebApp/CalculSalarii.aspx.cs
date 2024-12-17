using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SalaryStatementWebApp
{
    public partial class CalculSalarii : System.Web.UI.Page
    {
        // Connection string (ensure you replace "DefaultConnection" with the actual connection string name in your web.config)
        private string connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadAllEmployees();
            }
        }

        private void LoadAllEmployees()
        {
            // SQL query to fetch employee data from the database
            string query = "SELECT nr_crt, nume, prenume, functie, salar_baza, spor_percent, premii_brute, total_brut, brut_impozabil, cas, cass, impozit, virat_card FROM Angajati";

            // Create a connection to the database
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                // Create a command object with the query and the connection
                SqlCommand cmd = new SqlCommand(query, conn);

                // Open the connection
                conn.Open();

                // Execute the query and fill the DataTable with the result
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                // Bind the data to the GridView
                gvResults.DataSource = dt;
                gvResults.DataBind();
            }
        }

        protected void btnCalculate_Click(object sender, EventArgs e)
        {
            // Clear previous messages
            lblMessage.Text = "";
            lblSuccessMessage.Text = "";

            int baseSalary;
            int bonusPercent;
            int premiiBrute;

            // Validate inputs
            if (!int.TryParse(txtSalarBaza.Text, out baseSalary))
            {
                lblMessage.Text = "Salariul de bază trebuie să fie un număr valid.";
                return;
            }

            if (baseSalary < 3700)
            {
                lblMessage.Text = "Salariul de bază trebuie să fie cel puțin 3700.";
                return;
            }

            if (!int.TryParse(txtSporPercent.Text, out bonusPercent))
            {
                lblMessage.Text = "Procentul de spor trebuie să fie un număr valid.";
                return;
            }

            if (bonusPercent < 0 || bonusPercent > 100)
            {
                lblMessage.Text = "Procentul de spor trebuie să fie între 0 și 100.";
                return;
            }

            if (!int.TryParse(txtPremiiBrute.Text, out premiiBrute))
            {
                lblMessage.Text = "Premiile brute trebuie să fie un număr valid.";
                return;
            }

            // Calcularea salariilor
            int totalGross = baseSalary + (baseSalary * bonusPercent / 100) + premiiBrute;

            // Ensure the gross salary is not less than 3700
            if (totalGross < 3700)
            {
                totalGross = 3700;
            }

            int cas = totalGross * 25 / 100;
            int cass = totalGross * 10 / 100;
            int taxableIncome = totalGross - (cas + cass);
            int tax = taxableIncome * 10 / 100;
            int viratCard = totalGross - (tax + cas + cass);

            // Adăugarea rezultatelor în GridView
            DataTable dt = gvResults.DataSource as DataTable;
            if (dt == null)
            {
                dt = new DataTable();
                dt.Columns.Add("Salariu Baza");
                dt.Columns.Add("Procent Spor");
                dt.Columns.Add("Premii Brute");
                dt.Columns.Add("CAS (25%)");
                dt.Columns.Add("CASS (10%)");
                dt.Columns.Add("Impozit (10%)");
                dt.Columns.Add("VIRAT_CARD");
            }
            dt.Rows.Add(baseSalary, bonusPercent, premiiBrute, cas, cass, tax, viratCard);
            gvResults.DataSource = dt;
            gvResults.DataBind();

            lblSuccessMessage.Text = "Calculul a fost realizat cu succes!";
        }
    }
}
