using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.Configuration;
using Microsoft.Reporting.WebForms;

namespace SalaryStatementWebApp
{
    public partial class Fluturas : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadReport(); // Load the report when the page first loads
            }
        }

        protected void btnExportPDF_Click(object sender, EventArgs e)
        {
            ExportReportToPDF(); // Export report to PDF when button is clicked
        }

        private void LoadReport()
        {
            DataTable dt = GetEmployeeData(); // Method to fetch employee data

            if (dt != null && dt.Rows.Count > 0)
            {
                ReportDataSource rds = new ReportDataSource("FluturasiStatement", dt); // Ensure this matches your dataset name
                ReportViewer1.LocalReport.DataSources.Clear(); // Use the correct ID here
                ReportViewer1.LocalReport.DataSources.Add(rds);
                ReportViewer1.LocalReport.ReportPath = Server.MapPath("Fluturas.rdlc"); // Ensure this is correct
                ReportViewer1.LocalReport.Refresh();
            }
            else
            {
                lblMessage.Text = "Nu sunt disponibile date pentru raport."; // No data available message
            }
        }

        private DataTable GetEmployeeData()
        {
            string connectionString = WebConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString; // Your connection string
            DataTable dt = new DataTable();

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = @"
                SELECT 
                    ROW_NUMBER() OVER (ORDER BY Nume) AS nr_crt,
                    Nume,
                    Prenume,
                    Functie,
                    Salar_Baza,
                    Spor_Percent,
                    Premii_Brute,
                    Total_Brut,
                    Brut_Impozabil,
                    CAS,
                    CASS,
                    Impozit,
                    Virat_Card,
                    Retineri
                FROM Angajati";

                using (SqlDataAdapter da = new SqlDataAdapter(query, conn))
                {
                    da.Fill(dt);
                }
            }

            return dt;
        }

        private void ExportReportToPDF()
        {
            // Prepare the report for exporting
            LocalReport report = ReportViewer1.LocalReport; // Use the correct ID here
            report.Refresh();

            string mimeType;
            string encoding;
            string fileNameExtension;

            string[] streams;
            Warning[] warnings;

            byte[] renderedBytes;

            // Render the report
            renderedBytes = report.Render(
                "PDF", null, out mimeType, out encoding,
                out fileNameExtension, out streams, out warnings);

            // Send the PDF to the client
            Response.Clear();
            Response.ContentType = mimeType;
            Response.AddHeader("content-disposition", "attachment; filename=Fluturas." + fileNameExtension);
            Response.BinaryWrite(renderedBytes);
            Response.End();
        }
    }
}
