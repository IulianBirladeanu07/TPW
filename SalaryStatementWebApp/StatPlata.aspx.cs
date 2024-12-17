using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.Configuration;
using Microsoft.Reporting.WebForms;

namespace SalaryStatementWebApp
{
    public partial class StatPlata : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadReport();
            }
        }

        protected void btnExportPDF_Click(object sender, EventArgs e)
        {
            ExportReportToPDF();
        }

        private void LoadReport()
        {
            DataTable dt = GetEmployeeData();

            if (dt != null && dt.Rows.Count > 0)
            {
                ReportDataSource rds = new ReportDataSource("AngajatiDataSet", dt);
                ReportViewer1.LocalReport.DataSources.Clear();
                ReportViewer1.LocalReport.DataSources.Add(rds);
                ReportViewer1.LocalReport.ReportPath = Server.MapPath("StatPlata.rdlc");
                ReportViewer1.LocalReport.Refresh();
            }
            else
            {
                lblMessage.Text = "No data available for the report.";
            }
        }

        private DataTable GetEmployeeData()
        {
            string connectionString = WebConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
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
                    Retineri,
                    Virat_Card
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
            LocalReport report = ReportViewer1.LocalReport;
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
            Response.AddHeader("content-disposition", "attachment; filename=StatDePlata." + fileNameExtension);
            Response.BinaryWrite(renderedBytes);
            Response.End();
        }
    }
}
