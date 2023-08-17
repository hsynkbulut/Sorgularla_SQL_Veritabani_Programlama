using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

using System.Data.SqlClient;

namespace Proje_SQL_DB
{
    public partial class FrmKategoriler : Form
    {
        public FrmKategoriler()
        {
            InitializeComponent();
        }

        SqlConnection baglanti = new SqlConnection(@"Data Source=DESKTOP-289OM95;Initial Catalog=SatisVT;Integrated Security=True");

        private void label2_Click(object sender, EventArgs e)
        {

        }

        private void textBox2_TextChanged(object sender, EventArgs e)
        {

        }

        private void BtnListele_Click(object sender, EventArgs e)
        {
            //SQL sorgu komutunu yazma
            SqlCommand komut = new SqlCommand("Select * From TBLKATEGORI", baglanti);

            SqlDataAdapter da = new SqlDataAdapter(komut);

            //Veri tablosu oluşturma
            DataTable dt = new DataTable();

            //DataAdapter'ı bu veri tablosu ile doldur
            da.Fill(dt);

            //Veri kaynağını dt'den yani oluşturduğumuz tablodan çek
            dataGridView1.DataSource = dt;
        }

        private void BtnKaydet_Click(object sender, EventArgs e)
        {
            baglanti.Open();
            SqlCommand komut2 = new SqlCommand("insert into TBLKATEGORI (KATEGORIAD) values (@p1)", baglanti);
            komut2.Parameters.AddWithValue("@p1", TxtKategoriAd.Text);

            //Değişiklikleri kaydet
            komut2.ExecuteNonQuery();

            baglanti.Close();
            MessageBox.Show("Kategori Kaydetme İşlemi Başarıyla Gerçekleşti");
        }

        private void dataGridView1_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {
            //Text alanına, seçili olan verinin değerini yazdırmak için
            TxtKategoriID.Text = dataGridView1.Rows[e.RowIndex].Cells[0].Value.ToString();
            TxtKategoriAd.Text = dataGridView1.Rows[e.RowIndex].Cells[1].Value.ToString();
        }

        private void BtnSil_Click(object sender, EventArgs e)
        {
            baglanti.Open();
            SqlCommand komut3 = new SqlCommand("Delete From TBLKATEGORI where KATEGORIID=@p1", baglanti);
            komut3.Parameters.AddWithValue("@p1", TxtKategoriID.Text);

            //Değişiklikleri kaydet
            komut3.ExecuteNonQuery();

            baglanti.Close();
            MessageBox.Show("Kategori Silme İşlemi Başarıyla Gerçekleşti");
        }

        private void BtnGuncelle_Click(object sender, EventArgs e)
        {
            baglanti.Open();
            SqlCommand komut4 = new SqlCommand("Update TBLKATEGORI set KATEGORIAD=@p1 where KATEGORIID=@p2", baglanti);
            komut4.Parameters.AddWithValue("@p1", TxtKategoriAd.Text);
            komut4.Parameters.AddWithValue("@p2", TxtKategoriID.Text);

            //Değişiklikleri kaydet
            komut4.ExecuteNonQuery();

            baglanti.Close();
            MessageBox.Show("Kategori Güncelleme İşlemi Başarıyla Gerçekleşti");
        }

        private void TxtKategoriID_TextChanged(object sender, EventArgs e)
        {

        }
    }
}
// Data Source=DESKTOP-289OM95;Initial Catalog=SatisVT;Integrated Security=True