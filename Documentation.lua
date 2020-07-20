--[[ 																																					   --[[

                                             
									,--.  ,--. ,-----. ,--.,------. ,------.,--. ,---.   
									|  ,'.|  |'  .-.  '|  ||  .--. '|  .---'|  |'   .-'  
									|  |' '  ||  | |  ||  ||  '--'.'|  `--, `-' `.  `-.  
									|  | `   |'  '-'  '|  ||  |\  \ |  `---.    .-'    | 
									`--'  `--' `-----' `--'`--' '--'`------'    `-----'  
											______ _   _ _   _ _____  _____ _____ _   _ _____________   __
											|  _  \ | | | \ | |  __ \|  ___|  _  | \ | |_   _|  ___\ \ / /
											| | | | | | |  \| | |  \/| |__ | | | |  \| | | | | |_   \ V / 
											| | | | | | | . ` | | __ |  __|| | | | . ` | | | |  _|   \ /  
											| |/ /| |_| | |\  | |_\ \| |___\ \_/ / |\  |_| |_| |     | |  
											|___/  \___/\_| \_/\____/\____/ \___/\_| \_/\___/\_|     \_/  
												                                                              
														                                                              
	                                                     

																																		
																																																																				
																																																																																																						
															This is Noire's Dungeonify.	
															  A highly customizable
														 and super quick dungeon generator.
											Be sure to read the DevForum page to see what this module can do.
																																																																																																																																																																																																																																																																				
														
																  # Methods #
																
													   Dungeonify:Bind(Instance container)
																
													   Binds the module to a pool of pieces.
													   Does not need to be a folder or model.
																																																																																																																																																																																																																																																																																																												
															-----------------------																																																																																																																																																																																													
																																																																																																																																																																																																																																														
														 Dungeonify:Debug(boolean toggle)	
																																																																																																																																																																																																																																																																							
														   Toggles hitbox visualization
														   Only for automated hitboxes.																																																																																																																																																																																																																																																																																																		
																																																																																																																																																																																																																																																																																																																																																				
															-----------------------
																																																																																																																																																																																																																																																																																																																																																																																						
													  Dungeonify:SetParent(instance container)																																																																																																																																																																																																																																																																																																																																																																																																										
																																																																																																																																																																																																																																																																																																																																																																																																																																																										
														   Sets the construction parent		
														   for pieces to be placed into.																																																																																																																																																																																																																																																																																																																																																																																																																																																																										
																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																														
															-----------------------																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																	
																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																		
													  Dungeonify:SetQuota(dictionary Quota?)
													
												   Establishes a quota for the generator to follow.
															 Can be empty or nil.
															
															-----------------------
															
											     Dungeonify:ImposeRestriction(dictionary Restrictions?)
											
												   Imposes restrictions for the generator to follow.
															  Can be empty or nil.
											
												
															-----------------------
															
													  Dungeonify:Generate(dictionary data?)
															
													Generates dungeon with the given parameters.
														
									{
										MaxPieces - number, maximum pieces allowed for the dungeon (required)
										MinPieces - number, minimum pieces that the generator has to provide
										[StartPiece, Start, StartingPiece] - string, string representation of the piece that the dungeon has to start with
										[StartCFrame, StartCF] - cframe, starting position of the generation
										[Addend, Addends] - dictionary, string representations of the pieces that will only be added at the end
									}
																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																									
																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																						]]--																																		  
