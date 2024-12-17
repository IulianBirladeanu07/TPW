using System;
using System.Data.SqlClient;
using System.Configuration;

namespace SalaryStatementWebApp
{
    public partial class ModificareImpozit : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadCurrentTaxPercentages();
            }
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            int casPercent, cassPercent, impozitPercent;
            string password = parola.Text;

            // Validate input
            if (!int.TryParse(cas.Text, out casPercent) ||
                !int.TryParse(cass.Text, out cassPercent) ||
                !int.TryParse(impozit.Text, out impozitPercent))
            {
                result.InnerText = "Introduceti un numar intreg valid.";
                return;
            }

            // Check if values are within the expected range
            if (casPercent < 0 || casPercent > 100 || cassPercent < 0 || cassPercent > 100 || impozitPercent < 0 || impozitPercent > 100)
            {
                result.InnerText = "Introduceti valori intre 0 si 100.";
                return;
            }

            // Check password and update the database
            if (ValidatePassword(password))
            {
                UpdateTaxPercentages(casPercent, cassPercent, impozitPercent);
            }   
            else
            {
                result.InnerText = "Invalid password.";
            }
        }

        private void LoadCurrentTaxPercentages()
        {
            string connectionString = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();
                string query = "SELECT cas_percent, cass_percent, impozit_percent FROM ProcenteSalarii WHERE id = 1"; // Adjust as needed
                SqlCommand command = new SqlCommand(query, connection);
                SqlDataReader reader = command.ExecuteReader();

                if (reader.Read())
                {
                    cas.Text = Convert.ToInt32(reader["cas_percent"]).ToString();
                    cass.Text = Convert.ToInt32(reader["cass_percent"]).ToString();
                    impozit.Text = Convert.ToInt32(reader["impozit_percent"]).ToString();
                }
            }
        }

        private bool ValidatePassword(string password)
        {
            string correctPasswordHash = "PAROLA"; // Replace with your logic
            return password == correctPasswordHash; // Simple comparison, use hashing for production
        }

        private void UpdateTaxPercentages(int cas, int cass, int impozit)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();
                string query = "UPDATE ProcenteSalarii SET cas_percent = @cas, cass_percent = @cass, impozit_percent = @impozit WHERE id = 1"; // Adjust as needed
                SqlCommand command = new SqlCommand(query, connection);
                command.Parameters.AddWithValue("@cas", cas);
                command.Parameters.AddWithValue("@cass", cass);
                command.Parameters.AddWithValue("@impozit", impozit);

                int rowsAffected = command.ExecuteNonQuery();
                if (rowsAffected > 0)
                {
                    result.InnerText = "Tax percentages updated successfully.";
                }
                else
                {
                    result.InnerText = "Error updating tax percentages.";
                }
            }
        }
    }
}
