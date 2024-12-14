using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SalaryStatementWebApp
{
    public partial class Calculator : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                InitializeGridView();
            }
        }

        private void InitializeGridView()
        {
            DataTable dt = new DataTable();
            dt.Columns.Add("Name");
            dt.Columns.Add("Function");
            dt.Columns.Add("Base Salary");
            dt.Columns.Add("Bonus");
            dt.Columns.Add("Premii Brute");
            dt.Columns.Add("CAS (25%)");
            dt.Columns.Add("CASS (10%)");
            dt.Columns.Add("Impozit (10%)");
            dt.Columns.Add("Net Salary");

            gvResults.DataSource = dt;
            gvResults.DataBind();
        }

        protected void btnCalculate_Click(object sender, EventArgs e)
        {
            // Get input values
            string name = txtName.Text;
            string function = txtFunction.Text;
            double baseSalary = double.Parse(txtBaseSalary.Text);
            double bonus = double.Parse(txtBonus.Text) / 100;
            double premiiBrute = double.Parse(txtPremiiBrute.Text);

            // Calculate derived values
            double totalGross = baseSalary + (baseSalary * bonus) + premiiBrute;
            double cas = totalGross * 0.25;
            double cass = totalGross * 0.10;
            double taxableIncome = totalGross - (cas + cass);
            double tax = taxableIncome * 0.10;
            double netSalary = taxableIncome - tax;

            // Add results to GridView
            DataTable dt = gvResults.DataSource as DataTable;
            dt.Rows.Add(name, function, baseSalary, bonus * 100, premiiBrute, cas, cass, tax, netSalary);

            gvResults.DataSource = dt;
            gvResults.DataBind();
        }
    }
}