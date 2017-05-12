namespace M2L_Mission3
{
    partial class Inscription
    {
        /// <summary>
        /// Variable nécessaire au concepteur.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Nettoyage des ressources utilisées.
        /// </summary>
        /// <param name="disposing">true si les ressources managées doivent être supprimées ; sinon, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Code généré par le Concepteur Windows Form

        /// <summary>
        /// Méthode requise pour la prise en charge du concepteur - ne modifiez pas
        /// le contenu de cette méthode avec l'éditeur de code.
        /// </summary>
        private void InitializeComponent()
        {
            this.dateTime_Arrive = new System.Windows.Forms.DateTimePicker();
            this.lbl_DateArrive = new MaterialSkin.Controls.MaterialLabel();
            this.btn_Enregistrer = new MaterialSkin.Controls.MaterialFlatButton();
            this.cmbBox_Participant = new System.Windows.Forms.ComboBox();
            this.lbl_Participant = new MaterialSkin.Controls.MaterialLabel();
            this.SuspendLayout();
            // 
            // dateTime_Arrive
            // 
            this.dateTime_Arrive.Location = new System.Drawing.Point(190, 165);
            this.dateTime_Arrive.Name = "dateTime_Arrive";
            this.dateTime_Arrive.Size = new System.Drawing.Size(200, 20);
            this.dateTime_Arrive.TabIndex = 9;
            // 
            // lbl_DateArrive
            // 
            this.lbl_DateArrive.AutoSize = true;
            this.lbl_DateArrive.Depth = 0;
            this.lbl_DateArrive.Font = new System.Drawing.Font("Roboto", 11F);
            this.lbl_DateArrive.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(222)))), ((int)(((byte)(0)))), ((int)(((byte)(0)))), ((int)(((byte)(0)))));
            this.lbl_DateArrive.Location = new System.Drawing.Point(65, 165);
            this.lbl_DateArrive.MouseState = MaterialSkin.MouseState.HOVER;
            this.lbl_DateArrive.Name = "lbl_DateArrive";
            this.lbl_DateArrive.Size = new System.Drawing.Size(99, 19);
            this.lbl_DateArrive.TabIndex = 26;
            this.lbl_DateArrive.Text = "Date Arrivée :";
            // 
            // btn_Enregistrer
            // 
            this.btn_Enregistrer.AutoSize = true;
            this.btn_Enregistrer.AutoSizeMode = System.Windows.Forms.AutoSizeMode.GrowAndShrink;
            this.btn_Enregistrer.Depth = 0;
            this.btn_Enregistrer.Location = new System.Drawing.Point(155, 218);
            this.btn_Enregistrer.Margin = new System.Windows.Forms.Padding(4, 6, 4, 6);
            this.btn_Enregistrer.MouseState = MaterialSkin.MouseState.HOVER;
            this.btn_Enregistrer.Name = "btn_Enregistrer";
            this.btn_Enregistrer.Primary = false;
            this.btn_Enregistrer.Size = new System.Drawing.Size(101, 36);
            this.btn_Enregistrer.TabIndex = 27;
            this.btn_Enregistrer.Text = "Enregistrer";
            this.btn_Enregistrer.UseVisualStyleBackColor = true;
            this.btn_Enregistrer.Click += new System.EventHandler(this.btn_Enregistrer_Click);
            // 
            // cmbBox_Participant
            // 
            this.cmbBox_Participant.FormattingEnabled = true;
            this.cmbBox_Participant.Location = new System.Drawing.Point(190, 89);
            this.cmbBox_Participant.Name = "cmbBox_Participant";
            this.cmbBox_Participant.Size = new System.Drawing.Size(121, 21);
            this.cmbBox_Participant.TabIndex = 28;
            this.cmbBox_Participant.SelectedIndexChanged += new System.EventHandler(this.comboBox1_SelectedIndexChanged);
            // 
            // lbl_Participant
            // 
            this.lbl_Participant.AutoSize = true;
            this.lbl_Participant.Depth = 0;
            this.lbl_Participant.Font = new System.Drawing.Font("Roboto", 11F);
            this.lbl_Participant.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(222)))), ((int)(((byte)(0)))), ((int)(((byte)(0)))), ((int)(((byte)(0)))));
            this.lbl_Participant.Location = new System.Drawing.Point(65, 88);
            this.lbl_Participant.MouseState = MaterialSkin.MouseState.HOVER;
            this.lbl_Participant.Name = "lbl_Participant";
            this.lbl_Participant.Size = new System.Drawing.Size(89, 19);
            this.lbl_Participant.TabIndex = 29;
            this.lbl_Participant.Text = "Participant :";
            // 
            // Inscription
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(442, 269);
            this.Controls.Add(this.lbl_Participant);
            this.Controls.Add(this.cmbBox_Participant);
            this.Controls.Add(this.btn_Enregistrer);
            this.Controls.Add(this.lbl_DateArrive);
            this.Controls.Add(this.dateTime_Arrive);
            this.Name = "Inscription";
            this.Text = "Enregistrement";
            this.Load += new System.EventHandler(this.Inscription_Load);
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion
        private System.Windows.Forms.DateTimePicker dateTime_Arrive;
        private MaterialSkin.Controls.MaterialLabel lbl_DateArrive;
        private MaterialSkin.Controls.MaterialFlatButton btn_Enregistrer;
        private System.Windows.Forms.ComboBox cmbBox_Participant;
        private MaterialSkin.Controls.MaterialLabel lbl_Participant;
    }
}

