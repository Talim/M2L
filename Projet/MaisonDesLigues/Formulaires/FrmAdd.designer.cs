namespace MaisonDesLigues
{
    partial class FrmAdd
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            this.materialTabSelector1 = new MaterialSkin.Controls.MaterialTabSelector();
            this.materialTabControl1 = new MaterialSkin.Controls.MaterialTabControl();
            this.tabPage1 = new System.Windows.Forms.TabPage();
            this.textBox_nbPlaceAtelier = new System.Windows.Forms.MaskedTextBox();
            this.materialLabel2 = new MaterialSkin.Controls.MaterialLabel();
            this.materialLabel1 = new MaterialSkin.Controls.MaterialLabel();
            this.btn_ajouterAtelier = new MaterialSkin.Controls.MaterialFlatButton();
            this.textField_atelier = new MaterialSkin.Controls.MaterialSingleLineTextField();
            this.tabPage2 = new System.Windows.Forms.TabPage();
            this.btn_AjouterTheme = new MaterialSkin.Controls.MaterialFlatButton();
            this.comboBox_Ateliers = new System.Windows.Forms.ComboBox();
            this.materialLabel4 = new MaterialSkin.Controls.MaterialLabel();
            this.materialLabel3 = new MaterialSkin.Controls.MaterialLabel();
            this.textField_LibelleTheme = new MaterialSkin.Controls.MaterialSingleLineTextField();
            this.tabPage3 = new System.Windows.Forms.TabPage();
            this.btn_AjouterVacations = new MaterialSkin.Controls.MaterialFlatButton();
            this.materialLabel7 = new MaterialSkin.Controls.MaterialLabel();
            this.textBox_HeureFin = new System.Windows.Forms.MaskedTextBox();
            this.materialLabel6 = new MaterialSkin.Controls.MaterialLabel();
            this.textBox_HeureDebut = new System.Windows.Forms.MaskedTextBox();
            this.comboBox_Atelier_Vacations = new System.Windows.Forms.ComboBox();
            this.materialLabel5 = new MaterialSkin.Controls.MaterialLabel();
            this.tabPage4 = new System.Windows.Forms.TabPage();
            this.btn_modifierVacation = new MaterialSkin.Controls.MaterialFlatButton();
            this.materialLabel8 = new MaterialSkin.Controls.MaterialLabel();
            this.textBox_HeureFinModifier = new System.Windows.Forms.MaskedTextBox();
            this.materialLabel9 = new MaterialSkin.Controls.MaterialLabel();
            this.textBox_heureDebutModifier = new System.Windows.Forms.MaskedTextBox();
            this.comboBox_Vacations = new System.Windows.Forms.ComboBox();
            this.materialLabel10 = new MaterialSkin.Controls.MaterialLabel();
            this.materialTabControl1.SuspendLayout();
            this.tabPage1.SuspendLayout();
            this.tabPage2.SuspendLayout();
            this.tabPage3.SuspendLayout();
            this.tabPage4.SuspendLayout();
            this.SuspendLayout();
            // 
            // materialTabSelector1
            // 
            this.materialTabSelector1.BaseTabControl = this.materialTabControl1;
            this.materialTabSelector1.Depth = 0;
            this.materialTabSelector1.Location = new System.Drawing.Point(0, 64);
            this.materialTabSelector1.MouseState = MaterialSkin.MouseState.HOVER;
            this.materialTabSelector1.Name = "materialTabSelector1";
            this.materialTabSelector1.Size = new System.Drawing.Size(536, 23);
            this.materialTabSelector1.TabIndex = 4;
            this.materialTabSelector1.Text = "materialTabSelector1";
            // 
            // materialTabControl1
            // 
            this.materialTabControl1.Controls.Add(this.tabPage1);
            this.materialTabControl1.Controls.Add(this.tabPage2);
            this.materialTabControl1.Controls.Add(this.tabPage3);
            this.materialTabControl1.Controls.Add(this.tabPage4);
            this.materialTabControl1.Depth = 0;
            this.materialTabControl1.Location = new System.Drawing.Point(8, 90);
            this.materialTabControl1.MouseState = MaterialSkin.MouseState.HOVER;
            this.materialTabControl1.Name = "materialTabControl1";
            this.materialTabControl1.SelectedIndex = 0;
            this.materialTabControl1.Size = new System.Drawing.Size(514, 159);
            this.materialTabControl1.TabIndex = 5;
            // 
            // tabPage1
            // 
            this.tabPage1.BackColor = System.Drawing.Color.White;
            this.tabPage1.Controls.Add(this.textBox_nbPlaceAtelier);
            this.tabPage1.Controls.Add(this.materialLabel2);
            this.tabPage1.Controls.Add(this.materialLabel1);
            this.tabPage1.Controls.Add(this.btn_ajouterAtelier);
            this.tabPage1.Controls.Add(this.textField_atelier);
            this.tabPage1.Location = new System.Drawing.Point(4, 22);
            this.tabPage1.Name = "tabPage1";
            this.tabPage1.Padding = new System.Windows.Forms.Padding(3);
            this.tabPage1.Size = new System.Drawing.Size(506, 133);
            this.tabPage1.TabIndex = 0;
            this.tabPage1.Text = "Ateliers";
            // 
            // textBox_nbPlaceAtelier
            // 
            this.textBox_nbPlaceAtelier.Location = new System.Drawing.Point(147, 61);
            this.textBox_nbPlaceAtelier.Mask = "00";
            this.textBox_nbPlaceAtelier.Name = "textBox_nbPlaceAtelier";
            this.textBox_nbPlaceAtelier.PromptChar = '0';
            this.textBox_nbPlaceAtelier.Size = new System.Drawing.Size(48, 20);
            this.textBox_nbPlaceAtelier.TabIndex = 11;
            // 
            // materialLabel2
            // 
            this.materialLabel2.AutoSize = true;
            this.materialLabel2.Depth = 0;
            this.materialLabel2.Font = new System.Drawing.Font("Roboto", 11F);
            this.materialLabel2.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(222)))), ((int)(((byte)(0)))), ((int)(((byte)(0)))), ((int)(((byte)(0)))));
            this.materialLabel2.Location = new System.Drawing.Point(11, 59);
            this.materialLabel2.MouseState = MaterialSkin.MouseState.HOVER;
            this.materialLabel2.Name = "materialLabel2";
            this.materialLabel2.Size = new System.Drawing.Size(131, 19);
            this.materialLabel2.TabIndex = 10;
            this.materialLabel2.Text = "Nombre de place :";
            // 
            // materialLabel1
            // 
            this.materialLabel1.AutoSize = true;
            this.materialLabel1.Depth = 0;
            this.materialLabel1.Font = new System.Drawing.Font("Roboto", 11F);
            this.materialLabel1.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(222)))), ((int)(((byte)(0)))), ((int)(((byte)(0)))), ((int)(((byte)(0)))));
            this.materialLabel1.Location = new System.Drawing.Point(11, 15);
            this.materialLabel1.MouseState = MaterialSkin.MouseState.HOVER;
            this.materialLabel1.Name = "materialLabel1";
            this.materialLabel1.Size = new System.Drawing.Size(61, 19);
            this.materialLabel1.TabIndex = 8;
            this.materialLabel1.Text = "Libellé :";
            // 
            // btn_ajouterAtelier
            // 
            this.btn_ajouterAtelier.AutoSize = true;
            this.btn_ajouterAtelier.AutoSizeMode = System.Windows.Forms.AutoSizeMode.GrowAndShrink;
            this.btn_ajouterAtelier.BackColor = System.Drawing.SystemColors.Control;
            this.btn_ajouterAtelier.Depth = 0;
            this.btn_ajouterAtelier.Location = new System.Drawing.Point(304, 51);
            this.btn_ajouterAtelier.Margin = new System.Windows.Forms.Padding(4, 6, 4, 6);
            this.btn_ajouterAtelier.MouseState = MaterialSkin.MouseState.HOVER;
            this.btn_ajouterAtelier.Name = "btn_ajouterAtelier";
            this.btn_ajouterAtelier.Primary = false;
            this.btn_ajouterAtelier.Size = new System.Drawing.Size(72, 36);
            this.btn_ajouterAtelier.TabIndex = 7;
            this.btn_ajouterAtelier.Text = "Ajouter";
            this.btn_ajouterAtelier.UseVisualStyleBackColor = false;
            this.btn_ajouterAtelier.Click += new System.EventHandler(this.btn_ajouterAtelier_Click);
            // 
            // textField_atelier
            // 
            this.textField_atelier.BackColor = System.Drawing.SystemColors.Control;
            this.textField_atelier.Depth = 0;
            this.textField_atelier.Hint = "";
            this.textField_atelier.Location = new System.Drawing.Point(76, 13);
            this.textField_atelier.MouseState = MaterialSkin.MouseState.HOVER;
            this.textField_atelier.Name = "textField_atelier";
            this.textField_atelier.PasswordChar = '\0';
            this.textField_atelier.SelectedText = "";
            this.textField_atelier.SelectionLength = 0;
            this.textField_atelier.SelectionStart = 0;
            this.textField_atelier.Size = new System.Drawing.Size(300, 23);
            this.textField_atelier.TabIndex = 0;
            this.textField_atelier.UseSystemPasswordChar = false;
            // 
            // tabPage2
            // 
            this.tabPage2.BackColor = System.Drawing.Color.White;
            this.tabPage2.Controls.Add(this.btn_AjouterTheme);
            this.tabPage2.Controls.Add(this.comboBox_Ateliers);
            this.tabPage2.Controls.Add(this.materialLabel4);
            this.tabPage2.Controls.Add(this.materialLabel3);
            this.tabPage2.Controls.Add(this.textField_LibelleTheme);
            this.tabPage2.Location = new System.Drawing.Point(4, 22);
            this.tabPage2.Name = "tabPage2";
            this.tabPage2.Padding = new System.Windows.Forms.Padding(3);
            this.tabPage2.Size = new System.Drawing.Size(506, 133);
            this.tabPage2.TabIndex = 1;
            this.tabPage2.Text = "Themes";
            // 
            // btn_AjouterTheme
            // 
            this.btn_AjouterTheme.AutoSize = true;
            this.btn_AjouterTheme.AutoSizeMode = System.Windows.Forms.AutoSizeMode.GrowAndShrink;
            this.btn_AjouterTheme.BackColor = System.Drawing.SystemColors.Control;
            this.btn_AjouterTheme.Depth = 0;
            this.btn_AjouterTheme.Location = new System.Drawing.Point(304, 51);
            this.btn_AjouterTheme.Margin = new System.Windows.Forms.Padding(4, 6, 4, 6);
            this.btn_AjouterTheme.MouseState = MaterialSkin.MouseState.HOVER;
            this.btn_AjouterTheme.Name = "btn_AjouterTheme";
            this.btn_AjouterTheme.Primary = false;
            this.btn_AjouterTheme.Size = new System.Drawing.Size(72, 36);
            this.btn_AjouterTheme.TabIndex = 13;
            this.btn_AjouterTheme.Text = "Ajouter";
            this.btn_AjouterTheme.UseVisualStyleBackColor = false;
            this.btn_AjouterTheme.Click += new System.EventHandler(this.btn_AjouterTheme_Click);
            // 
            // comboBox_Ateliers
            // 
            this.comboBox_Ateliers.FormattingEnabled = true;
            this.comboBox_Ateliers.Location = new System.Drawing.Point(78, 60);
            this.comboBox_Ateliers.Name = "comboBox_Ateliers";
            this.comboBox_Ateliers.Size = new System.Drawing.Size(194, 21);
            this.comboBox_Ateliers.TabIndex = 12;
            // 
            // materialLabel4
            // 
            this.materialLabel4.AutoSize = true;
            this.materialLabel4.Depth = 0;
            this.materialLabel4.Font = new System.Drawing.Font("Roboto", 11F);
            this.materialLabel4.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(222)))), ((int)(((byte)(0)))), ((int)(((byte)(0)))), ((int)(((byte)(0)))));
            this.materialLabel4.Location = new System.Drawing.Point(11, 59);
            this.materialLabel4.MouseState = MaterialSkin.MouseState.HOVER;
            this.materialLabel4.Name = "materialLabel4";
            this.materialLabel4.Size = new System.Drawing.Size(61, 19);
            this.materialLabel4.TabIndex = 11;
            this.materialLabel4.Text = "Atelier :";
            // 
            // materialLabel3
            // 
            this.materialLabel3.AutoSize = true;
            this.materialLabel3.Depth = 0;
            this.materialLabel3.Font = new System.Drawing.Font("Roboto", 11F);
            this.materialLabel3.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(222)))), ((int)(((byte)(0)))), ((int)(((byte)(0)))), ((int)(((byte)(0)))));
            this.materialLabel3.Location = new System.Drawing.Point(11, 15);
            this.materialLabel3.MouseState = MaterialSkin.MouseState.HOVER;
            this.materialLabel3.Name = "materialLabel3";
            this.materialLabel3.Size = new System.Drawing.Size(61, 19);
            this.materialLabel3.TabIndex = 10;
            this.materialLabel3.Text = "Libellé :";
            // 
            // textField_LibelleTheme
            // 
            this.textField_LibelleTheme.BackColor = System.Drawing.SystemColors.Control;
            this.textField_LibelleTheme.Depth = 0;
            this.textField_LibelleTheme.Hint = "";
            this.textField_LibelleTheme.Location = new System.Drawing.Point(76, 13);
            this.textField_LibelleTheme.MouseState = MaterialSkin.MouseState.HOVER;
            this.textField_LibelleTheme.Name = "textField_LibelleTheme";
            this.textField_LibelleTheme.PasswordChar = '\0';
            this.textField_LibelleTheme.SelectedText = "";
            this.textField_LibelleTheme.SelectionLength = 0;
            this.textField_LibelleTheme.SelectionStart = 0;
            this.textField_LibelleTheme.Size = new System.Drawing.Size(300, 23);
            this.textField_LibelleTheme.TabIndex = 9;
            this.textField_LibelleTheme.UseSystemPasswordChar = false;
            // 
            // tabPage3
            // 
            this.tabPage3.BackColor = System.Drawing.Color.White;
            this.tabPage3.Controls.Add(this.btn_AjouterVacations);
            this.tabPage3.Controls.Add(this.materialLabel7);
            this.tabPage3.Controls.Add(this.textBox_HeureFin);
            this.tabPage3.Controls.Add(this.materialLabel6);
            this.tabPage3.Controls.Add(this.textBox_HeureDebut);
            this.tabPage3.Controls.Add(this.comboBox_Atelier_Vacations);
            this.tabPage3.Controls.Add(this.materialLabel5);
            this.tabPage3.Location = new System.Drawing.Point(4, 22);
            this.tabPage3.Name = "tabPage3";
            this.tabPage3.Size = new System.Drawing.Size(506, 133);
            this.tabPage3.TabIndex = 2;
            this.tabPage3.Text = "Vacations";
            // 
            // btn_AjouterVacations
            // 
            this.btn_AjouterVacations.AutoSize = true;
            this.btn_AjouterVacations.AutoSizeMode = System.Windows.Forms.AutoSizeMode.GrowAndShrink;
            this.btn_AjouterVacations.BackColor = System.Drawing.SystemColors.Control;
            this.btn_AjouterVacations.Depth = 0;
            this.btn_AjouterVacations.Location = new System.Drawing.Point(201, 73);
            this.btn_AjouterVacations.Margin = new System.Windows.Forms.Padding(4, 6, 4, 6);
            this.btn_AjouterVacations.MouseState = MaterialSkin.MouseState.HOVER;
            this.btn_AjouterVacations.Name = "btn_AjouterVacations";
            this.btn_AjouterVacations.Primary = false;
            this.btn_AjouterVacations.Size = new System.Drawing.Size(72, 36);
            this.btn_AjouterVacations.TabIndex = 19;
            this.btn_AjouterVacations.Text = "Ajouter";
            this.btn_AjouterVacations.UseVisualStyleBackColor = false;
            this.btn_AjouterVacations.Click += new System.EventHandler(this.btn_AjouterVacations_Click);
            // 
            // materialLabel7
            // 
            this.materialLabel7.AutoSize = true;
            this.materialLabel7.Depth = 0;
            this.materialLabel7.Font = new System.Drawing.Font("Roboto", 11F);
            this.materialLabel7.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(222)))), ((int)(((byte)(0)))), ((int)(((byte)(0)))), ((int)(((byte)(0)))));
            this.materialLabel7.Location = new System.Drawing.Point(12, 88);
            this.materialLabel7.MouseState = MaterialSkin.MouseState.HOVER;
            this.materialLabel7.Name = "materialLabel7";
            this.materialLabel7.Size = new System.Drawing.Size(78, 19);
            this.materialLabel7.TabIndex = 18;
            this.materialLabel7.Text = "Heure fin :";
            // 
            // textBox_HeureFin
            // 
            this.textBox_HeureFin.Location = new System.Drawing.Point(116, 89);
            this.textBox_HeureFin.Mask = "00:00";
            this.textBox_HeureFin.Name = "textBox_HeureFin";
            this.textBox_HeureFin.PromptChar = '0';
            this.textBox_HeureFin.Size = new System.Drawing.Size(52, 20);
            this.textBox_HeureFin.TabIndex = 17;
            this.textBox_HeureFin.ValidatingType = typeof(System.DateTime);
            // 
            // materialLabel6
            // 
            this.materialLabel6.AutoSize = true;
            this.materialLabel6.Depth = 0;
            this.materialLabel6.Font = new System.Drawing.Font("Roboto", 11F);
            this.materialLabel6.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(222)))), ((int)(((byte)(0)))), ((int)(((byte)(0)))), ((int)(((byte)(0)))));
            this.materialLabel6.Location = new System.Drawing.Point(12, 50);
            this.materialLabel6.MouseState = MaterialSkin.MouseState.HOVER;
            this.materialLabel6.Name = "materialLabel6";
            this.materialLabel6.Size = new System.Drawing.Size(98, 19);
            this.materialLabel6.TabIndex = 16;
            this.materialLabel6.Text = "Heure début :";
            // 
            // textBox_HeureDebut
            // 
            this.textBox_HeureDebut.Location = new System.Drawing.Point(116, 51);
            this.textBox_HeureDebut.Mask = "00:00";
            this.textBox_HeureDebut.Name = "textBox_HeureDebut";
            this.textBox_HeureDebut.PromptChar = '0';
            this.textBox_HeureDebut.Size = new System.Drawing.Size(52, 20);
            this.textBox_HeureDebut.TabIndex = 15;
            this.textBox_HeureDebut.ValidatingType = typeof(System.DateTime);
            // 
            // comboBox_Atelier_Vacations
            // 
            this.comboBox_Atelier_Vacations.FormattingEnabled = true;
            this.comboBox_Atelier_Vacations.Location = new System.Drawing.Point(79, 14);
            this.comboBox_Atelier_Vacations.Name = "comboBox_Atelier_Vacations";
            this.comboBox_Atelier_Vacations.Size = new System.Drawing.Size(194, 21);
            this.comboBox_Atelier_Vacations.TabIndex = 14;
            // 
            // materialLabel5
            // 
            this.materialLabel5.AutoSize = true;
            this.materialLabel5.Depth = 0;
            this.materialLabel5.Font = new System.Drawing.Font("Roboto", 11F);
            this.materialLabel5.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(222)))), ((int)(((byte)(0)))), ((int)(((byte)(0)))), ((int)(((byte)(0)))));
            this.materialLabel5.Location = new System.Drawing.Point(12, 13);
            this.materialLabel5.MouseState = MaterialSkin.MouseState.HOVER;
            this.materialLabel5.Name = "materialLabel5";
            this.materialLabel5.Size = new System.Drawing.Size(61, 19);
            this.materialLabel5.TabIndex = 13;
            this.materialLabel5.Text = "Atelier :";
            // 
            // tabPage4
            // 
            this.tabPage4.BackColor = System.Drawing.Color.White;
            this.tabPage4.Controls.Add(this.btn_modifierVacation);
            this.tabPage4.Controls.Add(this.materialLabel8);
            this.tabPage4.Controls.Add(this.textBox_HeureFinModifier);
            this.tabPage4.Controls.Add(this.materialLabel9);
            this.tabPage4.Controls.Add(this.textBox_heureDebutModifier);
            this.tabPage4.Controls.Add(this.comboBox_Vacations);
            this.tabPage4.Controls.Add(this.materialLabel10);
            this.tabPage4.Location = new System.Drawing.Point(4, 22);
            this.tabPage4.Name = "tabPage4";
            this.tabPage4.Size = new System.Drawing.Size(506, 133);
            this.tabPage4.TabIndex = 3;
            this.tabPage4.Text = "Modifications";
            // 
            // btn_modifierVacation
            // 
            this.btn_modifierVacation.AutoSize = true;
            this.btn_modifierVacation.AutoSizeMode = System.Windows.Forms.AutoSizeMode.GrowAndShrink;
            this.btn_modifierVacation.BackColor = System.Drawing.SystemColors.Control;
            this.btn_modifierVacation.Depth = 0;
            this.btn_modifierVacation.Location = new System.Drawing.Point(201, 73);
            this.btn_modifierVacation.Margin = new System.Windows.Forms.Padding(4, 6, 4, 6);
            this.btn_modifierVacation.MouseState = MaterialSkin.MouseState.HOVER;
            this.btn_modifierVacation.Name = "btn_modifierVacation";
            this.btn_modifierVacation.Primary = false;
            this.btn_modifierVacation.Size = new System.Drawing.Size(74, 36);
            this.btn_modifierVacation.TabIndex = 26;
            this.btn_modifierVacation.Text = "Modifier";
            this.btn_modifierVacation.UseVisualStyleBackColor = false;
            this.btn_modifierVacation.Click += new System.EventHandler(this.btn_modifierVacation_Click);
            // 
            // materialLabel8
            // 
            this.materialLabel8.AutoSize = true;
            this.materialLabel8.Depth = 0;
            this.materialLabel8.Font = new System.Drawing.Font("Roboto", 11F);
            this.materialLabel8.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(222)))), ((int)(((byte)(0)))), ((int)(((byte)(0)))), ((int)(((byte)(0)))));
            this.materialLabel8.Location = new System.Drawing.Point(12, 88);
            this.materialLabel8.MouseState = MaterialSkin.MouseState.HOVER;
            this.materialLabel8.Name = "materialLabel8";
            this.materialLabel8.Size = new System.Drawing.Size(78, 19);
            this.materialLabel8.TabIndex = 25;
            this.materialLabel8.Text = "Heure fin :";
            // 
            // textBox_HeureFinModifier
            // 
            this.textBox_HeureFinModifier.Location = new System.Drawing.Point(116, 89);
            this.textBox_HeureFinModifier.Mask = "00:00";
            this.textBox_HeureFinModifier.Name = "textBox_HeureFinModifier";
            this.textBox_HeureFinModifier.PromptChar = '0';
            this.textBox_HeureFinModifier.Size = new System.Drawing.Size(52, 20);
            this.textBox_HeureFinModifier.TabIndex = 24;
            this.textBox_HeureFinModifier.ValidatingType = typeof(System.DateTime);
            // 
            // materialLabel9
            // 
            this.materialLabel9.AutoSize = true;
            this.materialLabel9.Depth = 0;
            this.materialLabel9.Font = new System.Drawing.Font("Roboto", 11F);
            this.materialLabel9.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(222)))), ((int)(((byte)(0)))), ((int)(((byte)(0)))), ((int)(((byte)(0)))));
            this.materialLabel9.Location = new System.Drawing.Point(12, 50);
            this.materialLabel9.MouseState = MaterialSkin.MouseState.HOVER;
            this.materialLabel9.Name = "materialLabel9";
            this.materialLabel9.Size = new System.Drawing.Size(98, 19);
            this.materialLabel9.TabIndex = 23;
            this.materialLabel9.Text = "Heure début :";
            // 
            // textBox_heureDebutModifier
            // 
            this.textBox_heureDebutModifier.Location = new System.Drawing.Point(116, 51);
            this.textBox_heureDebutModifier.Mask = "00:00";
            this.textBox_heureDebutModifier.Name = "textBox_heureDebutModifier";
            this.textBox_heureDebutModifier.PromptChar = '0';
            this.textBox_heureDebutModifier.Size = new System.Drawing.Size(52, 20);
            this.textBox_heureDebutModifier.TabIndex = 22;
            this.textBox_heureDebutModifier.ValidatingType = typeof(System.DateTime);
            // 
            // comboBox_Vacations
            // 
            this.comboBox_Vacations.FormattingEnabled = true;
            this.comboBox_Vacations.Location = new System.Drawing.Point(79, 14);
            this.comboBox_Vacations.Name = "comboBox_Vacations";
            this.comboBox_Vacations.Size = new System.Drawing.Size(194, 21);
            this.comboBox_Vacations.TabIndex = 21;
            this.comboBox_Vacations.SelectedIndexChanged += new System.EventHandler(this.comboBox_Vacations_SelectedIndexChanged);
            // 
            // materialLabel10
            // 
            this.materialLabel10.AutoSize = true;
            this.materialLabel10.Depth = 0;
            this.materialLabel10.Font = new System.Drawing.Font("Roboto", 11F);
            this.materialLabel10.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(222)))), ((int)(((byte)(0)))), ((int)(((byte)(0)))), ((int)(((byte)(0)))));
            this.materialLabel10.Location = new System.Drawing.Point(12, 13);
            this.materialLabel10.MouseState = MaterialSkin.MouseState.HOVER;
            this.materialLabel10.Name = "materialLabel10";
            this.materialLabel10.Size = new System.Drawing.Size(77, 19);
            this.materialLabel10.TabIndex = 20;
            this.materialLabel10.Text = "Vacation :";
            // 
            // FrmAdd
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(524, 257);
            this.Controls.Add(this.materialTabSelector1);
            this.Controls.Add(this.materialTabControl1);
            this.Name = "FrmAdd";
            this.Sizable = false;
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
            this.Text = "Application Assises de l\'Escrime";
            this.Load += new System.EventHandler(this.FrmAdd_Load);
            this.materialTabControl1.ResumeLayout(false);
            this.tabPage1.ResumeLayout(false);
            this.tabPage1.PerformLayout();
            this.tabPage2.ResumeLayout(false);
            this.tabPage2.PerformLayout();
            this.tabPage3.ResumeLayout(false);
            this.tabPage3.PerformLayout();
            this.tabPage4.ResumeLayout(false);
            this.tabPage4.PerformLayout();
            this.ResumeLayout(false);

        }

        #endregion
        private MaterialSkin.Controls.MaterialTabSelector materialTabSelector1;
        private MaterialSkin.Controls.MaterialTabControl materialTabControl1;
        private System.Windows.Forms.TabPage tabPage1;
        private System.Windows.Forms.TabPage tabPage2;
        private System.Windows.Forms.TabPage tabPage3;
        private MaterialSkin.Controls.MaterialSingleLineTextField textField_atelier;
        private MaterialSkin.Controls.MaterialFlatButton btn_ajouterAtelier;
        private MaterialSkin.Controls.MaterialLabel materialLabel1;
        private MaterialSkin.Controls.MaterialLabel materialLabel2;
        private MaterialSkin.Controls.MaterialFlatButton btn_AjouterTheme;
        private System.Windows.Forms.ComboBox comboBox_Ateliers;
        private MaterialSkin.Controls.MaterialLabel materialLabel4;
        private MaterialSkin.Controls.MaterialLabel materialLabel3;
        private MaterialSkin.Controls.MaterialSingleLineTextField textField_LibelleTheme;
        private System.Windows.Forms.ComboBox comboBox_Atelier_Vacations;
        private MaterialSkin.Controls.MaterialLabel materialLabel5;
        private System.Windows.Forms.MaskedTextBox textBox_HeureDebut;
        private MaterialSkin.Controls.MaterialFlatButton btn_AjouterVacations;
        private MaterialSkin.Controls.MaterialLabel materialLabel7;
        private System.Windows.Forms.MaskedTextBox textBox_HeureFin;
        private MaterialSkin.Controls.MaterialLabel materialLabel6;
        private System.Windows.Forms.TabPage tabPage4;
        private MaterialSkin.Controls.MaterialFlatButton btn_modifierVacation;
        private MaterialSkin.Controls.MaterialLabel materialLabel8;
        private System.Windows.Forms.MaskedTextBox textBox_HeureFinModifier;
        private MaterialSkin.Controls.MaterialLabel materialLabel9;
        private System.Windows.Forms.MaskedTextBox textBox_heureDebutModifier;
        private System.Windows.Forms.ComboBox comboBox_Vacations;
        private MaterialSkin.Controls.MaterialLabel materialLabel10;
        private System.Windows.Forms.MaskedTextBox textBox_nbPlaceAtelier;
    }
}