using BaseDeDonnees;
using MaterialSkin;
using MaterialSkin.Controls;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace M2L_Mission3
{
    public partial class Inscription : MaterialForm
    {
        private readonly MaterialSkinManager materialSkinManager;

        private Bdd _connection;

        public Inscription()
        {
            InitializeComponent();
            materialSkinManager = MaterialSkinManager.Instance;
            materialSkinManager.AddFormToManage(this);
            materialSkinManager.Theme = MaterialSkinManager.Themes.LIGHT;
            materialSkinManager.ColorScheme = new ColorScheme(Primary.BlueGrey800, Primary.BlueGrey900, Primary.BlueGrey500, Accent.LightBlue200, TextShade.WHITE);
            this._connection= new Bdd("mdl", "mdl");
        }

        private void btn_Enregistrer_Click(object sender, EventArgs e)
        {
            this._connection.AddParticipant(
                txtBox_Nom.Text, txtBox_Prenom.Text,txtBox_Adresse1.Text,
                txtBox_Adresse2.Text,txtBox_Cp.Text, txtBox_Ville.Text, 
                txtBox_Tel.Text,txtBox_Mail.Text,dateTime_Inscription.Value.ToString(),
                dateTime_Arrive.Value.ToString(), Utilitaire.generateWifi(12));
        }

    }
}
