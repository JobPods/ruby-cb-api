module Cb
	class CbApp
		attr_accessor :did, :title, :requirements,
                  :apply_url, :submit_service_url, :is_shared_apply,
                  :total_questions, :total_required_questions, :questions
		#################################################################
		## This general purpose object stores anything having to do with 
    ## an application. The API objects dealing with application,
    ## will populate one or many of this object.
		#################################################################

		def initialize(args = {})
      return if args.nil?

			# Job Info related
			@did                      = args['JobDID'] || ''
			@title       			        = args['JobTitle'] || ''
      @requirements             = args['Requirements'] || ''

			# Apply URL related
			@submit_service_url       = args['ApplicationSubmitServiceURL'] || ''
			@apply_url       			    = (args['ApplyURL'].downcase == 'true')
      @is_shared_apply          = args['IsSharedApply'] || ''

			# Question related
			@total_questions       		= args['TotalQuestions'] || ''
			@total_required_questions	= args['TotalRequiredQuestions'] || ''
      @total_questions = @total_questions.to_i if Cb::Utils::Api.is_numeric? @total_questions
      @total_required_questions = @total_required_questions.to_i if Cb::Utils::Api.is_numeric? @total_required_questions

      @questions = []
      if args.has_key?('Questions')
        unless args['Questions'].empty?
          args['Questions']['Question'].each do | qq |
            @questions << CbApp::CbQuestion.new(qq)
          end
        end
      end
		end # Initialize
  end # CbApp

  class CbApp::CbQuestion
    attr_accessor :id, :type, :required, :format, :text

    def initialize(args = {})
      return if args.nil?

      @id       = args['QuestionID'] || ''
      @type     = args['QuestionType'] || ''
      @required = (args['IsRequired'].downcase == 'true')
      @format   = args['ExpectedResponseFormat'] || ''
      @text     = args['QuestionText'] || ''
    end
  end # CbQuestion

  class CbApp::CbAnswer


  end # CbAnswer
end
#
#<Answers>
#<Answer>
#<QuestionID>MeetsRequirements</QuestionID>
#            <AnswerID>Yes</AnswerID>
#<AnswerText>Yes</AnswerText>
#          </Answer>
#<Answer>
#<QuestionID>MeetsRequirements</QuestionID>
#            <AnswerID>No</AnswerID>
#<AnswerText>No</AnswerText>
#          </Answer>
#</Answers>