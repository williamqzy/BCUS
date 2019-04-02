=begin comments
Copyright © 2016 , UChicago Argonne, LLC
All Rights Reserved
OPEN SOURCE LICENSE

Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:

1. Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.  Software changes, modifications, or derivative works, should be noted with comments and the author and organization’s name.

2. Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.

3. Neither the names of UChicago Argonne, LLC or the Department of Energy nor the names of its contributors may be used to endorse or promote products derived from this software without specific prior written permission.

4. The software and the end-user documentation included with the redistribution, if any, must include the following acknowledgment:

   "This product includes software produced by UChicago Argonne, LLC under Contract No. DE-AC02-06CH11357 with the Department of Energy.”

******************************************************************************************************
DISCLAIMER

THE SOFTWARE IS SUPPLIED "AS IS" WITHOUT WARRANTY OF ANY KIND.

NEITHER THE UNITED STATES GOVERNMENT, NOR THE UNITED STATES DEPARTMENT OF ENERGY, NOR UCHICAGO ARGONNE, LLC, NOR ANY OF THEIR EMPLOYEES, MAKES ANY WARRANTY, EXPRESS OR IMPLIED, OR ASSUMES ANY LEGAL LIABILITY OR RESPONSIBILITY FOR THE ACCURACY, COMPLETENESS, OR USEFULNESS OF ANY INFORMATION, DATA, APPARATUS, PRODUCT, OR PROCESS DISCLOSED, OR REPRESENTS THAT ITS USE WOULD NOT INFRINGE PRIVATELY OWNED RIGHTS.

***************************************************************************************************


Modified Date and By:
- Created on July 2015 by Matt Riddle and Yuming Sun from Argonne National Laboratory


1. Introduction
This is the subfunction called by UbCRunner.rb to 
            1. Convert Ruby parameters into R parameters
			2. Call GraphPosteriors code in R

=end

#===============================================================%
#     author: Matt Riddle, Yuming Sun										%
#     date: Feb 27, 2015										%
#===============================================================%

# graphPosteriors: Function to call R function to graph the 
#         posterior distributions
#

#         Use this function to:
#            1. Convert Ruby parameters into R parameters
#			 2. Call GraphPosteriors code in R

# CALLED BY: bCRunner.rb
# CALLS: graphPosteriors.R

#==============================================================#
#                        REQUIRED INPUTS                       #
#==============================================================#
# params_filename: name of file holding info on parameter priors
# pvals_filename: name of file holding posterior distributions
#   generated by mcmc
# burnin: number of steps from mcmc results to be discarded 
#   before showing posterior distributions
# graphs_output_folder: folder that graphs will be saved in

#===============================================================#
#                           OUTPUTS                             #
#===============================================================#
# None, but graphPosteriors.R will generate pdf files with graphs
#===============================================================%

# graphPred: Function to graph predicted model results
#
#     this function is not currently being used

require 'rinruby'

# rubocop:disable Lint/UselessAssignment
R.echo(enabled = false)
# rubocop:enable Lint/UselessAssignment

module GraphGenerator
  def GraphGenerator.graphPosteriors(params_filename, pvals_filename, burnin, graphs_output_folder)

    R.eval("source('graphPosteriors.R')")
    R.assign('params_filename', params_filename)
    R.assign('pvals_filename', pvals_filename)
    R.assign('burnin', burnin)
    R.assign('graphs_output_folder', graphs_output_folder)
    R.eval('graphPosteriors(params_filename, pvals_filename, burnin, graphs_output_folder)')

  end

  def GraphGenerator.graphPred(com_filename, field_filename, expred_filename, yyxpred_filename)

    R.eval("source('graphPred.R')")
    R.assign('com_filename', com_filename)
    R.assign('field_filename', field_filename)
    R.assign('expred_filename', expred_filename)
    R.assign('yyxpred_filename', yyxpred_filename)
    R.eval('graphPred(com_filename, field_filename, expred_filename, yyxpred_filename)')

  end
end