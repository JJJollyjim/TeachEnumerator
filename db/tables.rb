DB.create_table?(:teachers) do
  primary_key :id
  String      :name,  :null => false
  String      :email, :null => false
  String      :secret
end

DB.create_table?(:students) do
  primary_key :id
  String      :name,  :null => false
  String      :email, :null => false
end

DB.create_table?(:testimonials) do
  primary_key :id
  Integer     :student_id, :null => false
  Integer     :teacher_id, :null => false

  # Has it been completed and submitted?
  TrueClass   :submitted,  :null => false, :default => false

  # 1-5 Ratings
  Integer     :rating_independence
  Integer     :rating_relationships
  Integer     :rating_maturity
  Integer     :rating_confidence
  Integer     :rating_academic

  # Long Form Comments
  String      :comments_independence,  :text => true
  String      :comments_relationships, :text => true
  String      :comments_maturity,      :text => true
  String      :comments_confidence,    :text => true
  String      :comments_academic,      :text => true

  # Long Form Comments
  String      :long_comments_general,  :text => true
  String      :long_comments_known,    :text => true
end
