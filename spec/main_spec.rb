describe "Application 'shoppinglist'" do
  before do
    @app = UIApplication.sharedApplication
  end

  it "is a ProMotion app" do
    @app.delegate.should.be.kind_of(PM::Delegate)
  end

  it "has two windows" do
    @app.windows.size.should == 2
  end

end
