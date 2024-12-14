using System;
using System.Data.SqlClient;
using System.Web.Configuration;
using System.Web.UI.WebControls;
using System.IO;

namespace SalaryStatementWebApp
{
    public partial class AdaugareAngajati : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Code to handle page load if necessary
        }

        protected void btnAdaugaAngajat_Click(object sender, EventArgs e)
        {
            // Retrieve form data
            string nume = txtNume.Text.Trim();
            string prenume = txtPrenume.Text.Trim();
            string functie = txtFunctie.Text.Trim();

            int salarBaza;
            int sporPercent;
            int premiiBrute;

            // Try parsing numeric fields with error handling
            if (!int.TryParse(txtSalarBaza.Text, out salarBaza))
            {
                lblMessage.Text = "Salariul de bază trebuie să fie un număr valid.";
                return;
            }
            if (!int.TryParse(txtSporPercent.Text, out sporPercent))
            {
                lblMessage.Text = "Procentul de spor trebuie să fie un număr valid.";
                return;
            }
            if (!int.TryParse(txtPremiiBrute.Text, out premiiBrute))
            {
                lblMessage.Text = "Premiile brute trebuie să fie un număr valid.";
                return;
            }

            // Handle file upload for employee photo
            string pozaPath = string.Empty;
            if (filePoza.HasFile)
            {
                string fileName = Path.GetFileName(filePoza.PostedFile.FileName);
                string fileExtension = Path.GetExtension(fileName).ToLower();
                string filePath = Server.MapPath("~/Uploads/") + fileName;

                // Validate file extension
                if (fileExtension != ".jpg" && fileExtension != ".jpeg" && fileExtension != ".png")
                {
                    lblMessage.Text = "Fișierul trebuie să fie o imagine de tip .jpg, .jpeg sau .png.";
                    return;
                }

                // Validate file size (max 2MB)
                if (filePoza.PostedFile.ContentLength > 5 * 1024 * 1024)
                {
                    lblMessage.Text = "Fișierul depășește dimensiunea maximă de 2MB.";
                    return;
                }

                try
                {
                    // Ensure the directory exists
                    string uploadPath = Server.MapPath("~/Uploads/");
                    if (!Directory.Exists(uploadPath))
                    {
                        Directory.CreateDirectory(uploadPath);
                    }

                    // Save the uploaded file
                    filePoza.SaveAs(filePath);
                    pozaPath = "~/Uploads/" + fileName;
                }
                catch (Exception ex)
                {
                    lblMessage.Text = "Eroare la încărcarea fișierului: " + ex.Message;
                    return;
                }
            }

            // Get connection string from web.config
            string connectionString = WebConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;

            // Insert employee data into database
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = @"
                    INSERT INTO Angajati (nume, prenume, functie, salar_baza, spor_percent, premii_brute, poza)
                    VALUES (@nume, @prenume, @functie, @salarBaza, @sporPercent, @premiiBrute, @poza)";

                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    // Add parameters to avoid SQL injection
                    cmd.Parameters.AddWithValue("@nume", nume);
                    cmd.Parameters.AddWithValue("@prenume", prenume);
                    cmd.Parameters.AddWithValue("@functie", functie);
                    cmd.Parameters.AddWithValue("@salarBaza", salarBaza);
                    cmd.Parameters.AddWithValue("@sporPercent", sporPercent);
                    cmd.Parameters.AddWithValue("@premiiBrute", premiiBrute);
                    cmd.Parameters.AddWithValue("@poza", pozaPath);

                    try
                    {
                        conn.Open();
                        cmd.ExecuteNonQuery();
                        lblMessage.Text = "Angajatul a fost adăugat cu succes!";
                        lblMessage.ForeColor = System.Drawing.Color.Green;
                    }
                    catch (Exception ex)
                    {
                        lblMessage.Text = "Eroare la adăugarea angajatului: " + ex.Message;
                        lblMessage.ForeColor = System.Drawing.Color.Red;
                    }
                }
            }
        }

        // Validate file method
        protected void ValidateFile(object sender, System.Web.UI.WebControls.ServerValidateEventArgs e)
        {
            FileUpload filePoza_ = filePoza;

            // Check if a file is uploaded
            if (filePoza_.HasFile)
            {
                string fileExtension = Path.GetExtension(filePoza_.PostedFile.FileName).ToLower();
                int fileSize = filePoza_.PostedFile.ContentLength;

                // Validate file extension
                if (fileExtension != ".jpg" && fileExtension != ".jpeg" && fileExtension != ".png")
                {
                    e.IsValid = false;  // Validation failed
                    return;
                }

                // Validate file size (5MB limit)
                if (fileSize > 5 * 1024 * 1024) // 2 MB
                {
                    e.IsValid = false;  // Validation failed
                    return;
                }
            }
            else
            {
                e.IsValid = false;  // No file uploaded
            }
        }
    }
}
