class Disperse

  STUDENTS = ["blake_darling", "chris_thielman", "eleanor_whitney", "elizel_albano", "george_bixby", "hunter_vurbeff", "ismail_colak", "jesika_wolff", "jm_freuler", "john_randall", "katie_donath", "martin_lerda", "max_bennett", "robbie_kanarek", "shehzad_khan", "vishal_reddy", "william_mantegna", "jamal_powell"]
  PWD = Dir.pwd

  def build_folders
    STUDENTS.each do |student|
      system("mkdir #{PWD}/__#{student}") unless Dir.exists?("#{PWD}/__#{student}")
    end
  end

  def assign_readme
    STUDENTS.each do |student|
      system("cp #{PWD}/README.md #{PWD}/__#{student}/")
    end
  end
end

disp = Disperse.new
disp.build_folders
disp.assign_readme
